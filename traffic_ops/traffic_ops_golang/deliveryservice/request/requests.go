package request

/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

import (
	"encoding/json"
	"errors"
	"fmt"
	"strconv"

	"github.com/apache/incubator-trafficcontrol/lib/go-log"
	"github.com/apache/incubator-trafficcontrol/lib/go-tc"

	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/auth"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/dbhelpers"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/deliveryservice"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/tenant"
	"github.com/jmoiron/sqlx"
	"github.com/lib/pq"
)

// TODeliveryServiceRequest provides a type alias to define functions on
type TODeliveryServiceRequest tc.DeliveryServiceRequestNullable

//the refType is passed into the handlers where a copy of its type is used to decode the json.
var refType = TODeliveryServiceRequest(tc.DeliveryServiceRequestNullable{})

// GetRefType is used to decode the JSON for deliveryservice requests
func GetRefType() *TODeliveryServiceRequest {
	return &refType
}

//Implementation of the Identifier, Validator interface functions

// GetID ...
func (req *TODeliveryServiceRequest) GetID() int {
	return req.ID
}

// GetAuditName ...
func (req *TODeliveryServiceRequest) GetAuditName() string {
	return strconv.Itoa(req.ID)
}

// GetType ...
func (req *TODeliveryServiceRequest) GetType() string {
	return "deliveryservice_request"
}

// SetID ...
func (req *TODeliveryServiceRequest) SetID(i int) {
	req.ID = i
}

// IsTenantAuthorized implements the Tenantable interface to ensure the user is authorized on the deliveryservice tenant
func (req *TODeliveryServiceRequest) IsTenantAuthorized(user auth.CurrentUser, db *sqlx.DB) (bool, error) {
	ds, err := req.getDeliveryService(db)
	if err != nil {
		log.Debugf("from getDeliveryService: %v", err)
		return false, err
	}
	return tenant.IsResourceAuthorizedToUser(ds.TenantID, user, db)
}

//The TODeliveryServiceRequest implementation of the Updater interface
//all implementations of Updater should use transactions and return the proper errorType
//ParsePQUniqueConstraintError is used to determine if a request with conflicting values exists
//if so, it will return an errorType of DataConflict and the type should be appended to the
//generic error message returned

// Update ...
func (req *TODeliveryServiceRequest) Update(db *sqlx.DB, user auth.CurrentUser) (error, tc.ApiErrorType) {
	tx, err := db.Beginx()
	defer func() {
		if tx == nil {
			return
		}
		if err == nil {
			err = tx.Commit()
		}
		if err != nil {
			tx.Rollback()
		}
	}()

	if err != nil {
		log.Error.Println("could not begin transaction: ", err.Error())
		return err, tc.SystemError
	}
	resultRows, err := tx.NamedQuery(updateRequestQuery(), req)
	if err != nil {
		if err, ok := err.(*pq.Error); ok {
			err, eType := dbhelpers.ParsePQUniqueConstraintError(err)
			if eType == tc.DataConflictError {
				return errors.New("a request with " + err.Error()), eType
			}
			return err, eType
		}
		log.Errorf("received error from update execution: %s", err.Error())
		return err, tc.SystemError
	}
	defer resultRows.Close()

	var lastUpdated tc.Time
	var rowsAffected int
	for resultRows.Next() {
		rowsAffected++
		if err = resultRows.Scan(&lastUpdated); err != nil {
			log.Error.Println("could not scan lastUpdated from insert: ", err.Error())
			return err, tc.SystemError
		}
	}
	log.Debugln("lastUpdated: ", lastUpdated)
	req.LastUpdated = &lastUpdated
	if rowsAffected < 1 {
		err = errors.New("no request found with this id")
		return err, tc.DataMissingError
	}
	if rowsAffected > 1 {
		err = fmt.Errorf("this update affected too many rows: %d", rowsAffected)
		return err, tc.SystemError
	}

	return nil, tc.NoError
}

//The TODeliveryServiceRequest implementation of the Inserter interface
//all implementations of Inserter should use transactions and return the proper errorType
//ParsePQUniqueConstraintError is used to determine if a request with conflicting values exists
//if so, it will return an errorType of DataConflict and the type should be appended to the
//generic error message returned
//The insert sql returns the id and lastUpdated values of the newly inserted request and have
//to be added to the struct

// Insert ...
func (req *TODeliveryServiceRequest) Insert(db *sqlx.DB, user auth.CurrentUser) (error, tc.ApiErrorType) {
	ds, err := req.getDeliveryService(db)
	if err != nil {
		return err, tc.SystemError
	}
	if ds.XMLID == nil {
		return errors.New("No xmlId associated with this request"), tc.DataMissingError
	}
	XMLID := *ds.XMLID

	active, err := isActiveRequest(db, XMLID)
	if err != nil {
		return err, tc.SystemError
	}
	if active {
		return errors.New("An active request exists for delivery service '" + XMLID), tc.DataConflictError
	}

	tx, err := db.Beginx()
	defer func() {
		if tx == nil {
			return
		}
		if err == nil {
			err = tx.Commit()
		}
		if err != nil {
			tx.Rollback()
		}
	}()

	if err != nil {
		log.Error.Println("could not begin transaction: ", err.Error())
		return tc.DBError, tc.SystemError
	}
	req.AuthorID = user.ID
	req.LastEditedByID = user.ID
	ir := insertRequestQuery()
	resultRows, err := tx.NamedQuery(ir, req)
	if err != nil {
		if err, ok := err.(*pq.Error); ok {
			err, eType := dbhelpers.ParsePQUniqueConstraintError(err)
			return err, eType
		}
		log.Errorln("received non pq error from create execution: ", err.Error())
		return err, tc.SystemError
	}
	defer resultRows.Close()

	var id int
	var lastUpdated tc.Time
	var rowsAffected int
	for resultRows.Next() {
		rowsAffected++
		if err = resultRows.Scan(&id, &lastUpdated); err != nil {
			log.Error.Println("could not scan id from insert: ", err.Error())
			return tc.DBError, tc.SystemError
		}
	}
	if rowsAffected == 0 {
		err = errors.New("no request was inserted, no id was returned")
		log.Errorln(err)
		return tc.DBError, tc.SystemError
	} else if rowsAffected > 1 {
		err = errors.New("too many ids returned from request insert")
		log.Errorln(err)
		return tc.DBError, tc.SystemError
	}
	req.SetID(id)
	req.LastUpdated = &lastUpdated
	return nil, tc.NoError
}

//The Request implementation of the Deleter interface
//all implementations of Deleter should use transactions and return the proper errorType

// Delete removes the request from the db
func (req *TODeliveryServiceRequest) Delete(db *sqlx.DB, user auth.CurrentUser) (error, tc.ApiErrorType) {
	fmt.Printf("DELETE\n")
	tx, err := db.Beginx()
	defer func() {
		if tx == nil {
			return
		}
		if err == nil {
			err = tx.Commit()
		}
		if err != nil {
			tx.Rollback()
		}
	}()

	if err != nil {
		log.Error.Println("could not begin transaction: ", err.Error())
		return tc.DBError, tc.SystemError
	}
	result, err := tx.NamedExec(deleteRequestQuery(), req)
	if err != nil {
		log.Errorln("received error from delete execution: ", err.Error())
		return tc.DBError, tc.SystemError
	}
	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return tc.DBError, tc.SystemError
	}
	if rowsAffected < 1 {
		return errors.New("no request with that id found"), tc.DataMissingError
	}
	if rowsAffected > 1 {
		return fmt.Errorf("this create affected too many rows: %d", rowsAffected), tc.SystemError
	}
	return nil, tc.NoError
}

// getDeliveryService retrieves a deliveryservice struct from the Request JSON
func (req TODeliveryServiceRequest) getDeliveryService(db *sqlx.DB) (deliveryservice.TODeliveryService, error) {
	var ds deliveryservice.TODeliveryService
	if req.DeliveryService == nil {
		if req.ID == 0 {
			log.Debugf("MISSING: %++v", req)
			return ds, errors.New("Missing DeliveryService data in request")
		}
		// get from the db
		q := `SELECT deliveryservice FROM deliveryservice_request WHERE id=` + strconv.Itoa(req.ID)
		row := db.QueryRow(q)
		err := row.Scan(&req.DeliveryService)
		if err != nil {
			return ds, err
		}
	}
	err := json.Unmarshal(req.DeliveryService, &ds)
	return ds, err
}

// isActiveRequest returns true if a request using this XMLID is currently in an active state
func isActiveRequest(db *sqlx.DB, XMLID string) (bool, error) {
	q := `SELECT EXISTS(SELECT 1 FROM deliveryservice_request
WHERE deliveryservice->>'xml_id' = '` + XMLID + `'
AND status IN ('draft', 'submitted', 'pending'))`
	row := db.QueryRow(q)
	var active bool
	err := row.Scan(&active)
	if err != nil {
		log.Debugln("ERROR: ", err, ";  QUERY:", q)
	}
	return active, err
}

func updateRequestQuery() string {
	query := `UPDATE
deliveryservice_request
SET assignee_id=:assignee_id,
change_type=:change_type,
last_edited_by_id=:last_edited_by_id,
deliveryservice=:deliveryservice,
status=:status
WHERE id=:id RETURNING last_updated`
	return query
}

func insertRequestQuery() string {
	query := `INSERT INTO deliveryservice_request (
assignee_id,
author_id,
change_type,
last_edited_by_id,
deliveryservice,
status
) VALUES (
:assignee_id,
:author_id,
:change_type,
:last_edited_by_id,
:deliveryservice,
:status
) RETURNING id,last_updated`
	return query
}

func deleteRequestQuery() string {
	query := `DELETE FROM deliveryservice_request
WHERE id=:id`
	return query
}
