package main

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
	"fmt"
	"net/url"
	"testing"

	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"

	tc "github.com/apache/incubator-trafficcontrol/lib/go-tc"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/test"
	"github.com/jmoiron/sqlx"
)

var sysInfoParameters = []tc.Parameter{
	tc.Parameter{
		ConfigFile:  "global",
		ID:          1,
		LastUpdated: "lastUpdated",
		Name:        "paramname1",
		Secure:      false,
		Value:       "val1",
	},

	tc.Parameter{
		ConfigFile:  "global",
		ID:          2,
		LastUpdated: "lastUpdated",
		Name:        "paramname2",
		Secure:      false,
		Value:       "val2",
	},
}

func TestGetSystemInfo(t *testing.T) {
	mockDB, mock, err := sqlmock.New()
	defer mockDB.Close()
	db := sqlx.NewDb(mockDB, "sqlmock")
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	cols := test.ColsFromStructByTag("db", tc.Parameter{})
	rows := sqlmock.NewRows(cols)

	//TODO: drichardson - build helper to add these Rows from the struct values
	//                    or by CSV if types get in the way
	for _, ts := range sysInfoParameters {
		rows = rows.AddRow(
			ts.ConfigFile,
			ts.ID,
			ts.LastUpdated,
			ts.Name,
			ts.Secure,
			ts.Value,
		)
	}

	mock.ExpectQuery("SELECT.*WHERE p.config_file='?").WillReturnRows(rows)
	v := url.Values{}

	sysinfo, err := getSystemInfo(v, db, PrivLevelReadOnly)
	if err != nil {
		t.Errorf("getSystemInfo expected: nil error, actual: %v", err)
	}

	if len(sysinfo) != 2 {
		t.Errorf("getSystemInfo expected: len(sysinfo) == 2, actual: %v", len(sysinfo))
		fmt.Printf("Got %+v\n", sysinfo)
	}
}
