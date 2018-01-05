package deliveryservice

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
	"errors"
	"fmt"
	"regexp"

	tcapi "github.com/apache/incubator-trafficcontrol/lib/go-tc/v13"
	validation "github.com/go-ozzo/ozzo-validation"
	"github.com/go-ozzo/ozzo-validation/is"
)

// Validate - validates a delivery service request
func Validate(ds tcapi.DeliveryService) []error {
	noSpaces := validation.Match(regexp.MustCompile("^\\S*$"))
	noSpaces.Error("cannot contain spaces")

	// Custom Examples:
	// Just add isCIDR as a parameter to Validate()
	// isCIDR := validation.NewStringRule(govalidator.IsCIDR, "must be a valid CIDR address")
	err := validation.Errors{
		"active":              validation.Validate(ds.Active, validation.NotNil),
		"cdnId":               validation.Validate(ds.CDNID, validation.NotNil),
		"displayName":         validation.Validate(ds.DisplayName, validation.Required),
		"dnsBypassIp":         validation.Validate(ds.DNSBypassIP, is.IP),
		"dnsBypassIp6":        validation.Validate(ds.DNSBypassIP6, is.IPv6),
		"dscp":                validation.Validate(ds.DSCP, validation.NotNil),
		"geoLimit":            validation.Validate(ds.GeoLimit, validation.NotNil),
		"geoProvider":         validation.Validate(ds.GeoProvider, validation.NotNil),
		"infoUrl":             validation.Validate(ds.InfoURL, is.URL),
		"logsEnabled":         validation.Validate(ds.LogsEnabled, validation.NotNil),
		"orgServerFqdn":       validation.Validate(ds.OrgServerFQDN, is.URL),
		"regionalGeoBlocking": validation.Validate(ds.RegionalGeoBlocking, validation.NotNil),
		"routingName":         validation.Validate(ds.RoutingName, validation.Length(1, 48)),
		"typeId":              validation.Validate(ds.TypeID, validation.NotNil),
		"xmlId":               validation.Validate(ds.XMLID, validation.Required, noSpaces, validation.Length(1, 48)),
	}

	return ToErrors(err)
}

// ToErrors - Flip to an array of errors
func ToErrors(err map[string]error) []error {
	vErrors := []error{}
	for key, value := range err {
		if value != nil {
			errMsg := fmt.Sprintf("'%v' %v", key, value)
			vErrors = append(vErrors, errors.New(errMsg))
		}
	}
	return vErrors
}
