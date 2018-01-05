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
	"encoding/json"
	"fmt"
	"strings"
	"testing"

	"github.com/apache/incubator-trafficcontrol/lib/go-tc/v13"
)

//Initial test fixture
const testCase = `
{
   "active": true,
   "cdnId": 1,
   "displayName": "disp1",
   "dnsBypassIp": "127.0.0.1",
   "dnsBypassIp6": "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
   "dscp": 0,
   "geoLimit": 0,
   "geoProvider": 0,
   "logsEnabled": true,
   "orgServerFqdn": "http://localhost",
   "regionalGeoBlocking": false,
   "typeId": 1,
   "xmlId": "ds1"
}
`

// TestValidate1 ...
func TestValidate1(t *testing.T) {

	var ds v13.DeliveryService
	if err := json.Unmarshal([]byte(testCase), &ds); err != nil {
		fmt.Printf("err ---> %v\n", err)
		return
	}

	errors := Validate(ds)
	for _, e := range errors {
		fmt.Printf("%s\n", e)
	}

	//displayName := "this is gonna be a name that's a little longer than the limit of 48 chars.."
	//expected := []string{
	//`display name '` + displayName + `' can be no longer than 48 characters`,
	//`missLat value -91 must not exceed +/- 90.0`,
	//`missLong value 102 must not exceed +/- 90.0`,
	//`cdnId is required`,
	//`xmlId is required`,
	//}

	//if len(expected) != len(errors) {
	//t.Errorf("Expected %d errors, got %d", len(expected), len(errors))
	//}
}

// TestValidate2 ...
func TestValidate2(t *testing.T) {

	var ds v13.DeliveryService
	if err := json.Unmarshal([]byte(testCase), &ds); err != nil {
		fmt.Printf("err ---> %v\n", err)
		return
	}
	// Test the routingName length
	routingName := strings.Repeat("#", 48)
	ds.RoutingName = routingName

	// Test the xmlId length
	xmlId := strings.Repeat("#", 48)
	ds.XMLID = &xmlId

	errors := Validate(ds)
	for _, e := range errors {
		fmt.Printf("%s\n", e)
	}

}
