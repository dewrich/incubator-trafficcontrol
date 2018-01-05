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
	"net/url"
	"testing"

	tcapi "github.com/apache/incubator-trafficcontrol/lib/go-tc/v13"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/test"
	"github.com/jmoiron/sqlx"

	sqlmock "gopkg.in/DATA-DOG/go-sqlmock.v1"
)

func getTestDeliveryServices() []tcapi.DeliveryService {
	//Initial test fixture
	const testCase = `
[
{
   "active": true,
   "ccrDnsTtl": 1,
   "cdnId": 1,
   "checkPath": "disp1",
   "displayName": "/crossdomain.xml",
   "dnsBypassCname": "cname",
   "dnsBypassIp": "127.0.0.1",
   "dnsBypassIp6": "2001:0db8:85a3:0000:0000:8a2e:0370:7334",
   "dnsBypassTTL": 10,
   "dscp": 0,
   "edgeHeaderRewrite": "cond %{REMAP_PSEUDO_HOOK} __RETURN__ set-config proxy.config.http.transaction_active_timeout_in 10800 [L]",
   "geoLimit": 0,
   "geoLimitCountries": "Can,Mex",
   "geoRedirectURL": "http://localhost/redirect",
   "geoProvider": 0,
   "globalMaxMBPS": 0,
   "globalMaxTPS": 0,
   "httpBypassFqdn": "http://bypass",
   "id": 1,
   "infoUrl": "http://info.url",
   "initialDispersion": 0,
   "ipv6RoutingEnabled": false,
   "lastUpdated": "2017-01-05 15:04:05+00",
   "logsEnabled": true,
   "longDesc": "longdesc",
   "longDesc1": "longdesc1",
   "longDesc2": "longdesc2",
   "maxDnsAnswers": 5,
   "midHeaderRewrite": "cond %{REMAP_PSEUDO_HOOK} __RETURN__ set-config proxy.config.http.cache.ignore_authentication 1 __RETURN__ set-config proxy.config.http.auth_server_session_private 0 __RETURN__ set-config proxy.config.http.transaction_no_activity_timeout_out 10 __RETURN__ set-config proxy.config.http.transaction_active_timeout_out 10  [L] __RETURN__",
   "missLat": -2.0,
   "missLong": -1.0,
   "multiSiteOrigin": false,
   "multiSiteOriginAlgorithm": 1,
   "orgServerFqdn": "http://localhost",
   "profile": 1,
   "protocol": 2,
   "qstringIgnore": 1,
   "rangeRequestHandling": 1,
   "regexRemap": "^/([^\/]+)/(.*) http://$1.foo.com/$2",
   "regionalGeoBlocking": false,
   "remapText": "@action=allow @src_ip=127.0.0.1-127.0.0.1",
   "routineName": "ccr",
   "signingAlgorithm": "url_sig",
   "sslKeyVersion": 1,
   "tenantId": 1,
   "trRequestHeaders": "xyz",
   "trResponseHeaders": "Access-Control-Allow-Origin: *",
   "typeId": 1,
   "xmlId": "ds1"
}
]
`
	var dses []tcapi.DeliveryService
	if err := json.Unmarshal([]byte(testCase), &dses); err != nil {
		fmt.Printf("err ---> %v\n", err)
		return nil
	}

	return dses
}

func TestGetDeliveryServices(t *testing.T) {
	mockDB, mock, err := sqlmock.New()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer mockDB.Close()

	db := sqlx.NewDb(mockDB, "sqlmock")
	defer db.Close()

	cols := test.ColsFromStructByTag("db", tcapi.DeliveryService{})
	rows := sqlmock.NewRows(cols)

	for _, ts := range getTestDeliveryServices() {
		rows = rows.AddRow(
			ts.Active,
			ts.CacheURL,
			ts.CCRDNSTTL,
			ts.CDNID,
			ts.CheckPath,
			ts.DisplayName,
			ts.DNSBypassCNAME,
			ts.DNSBypassIP,
			ts.DNSBypassIP6,
			ts.DNSBypassTTL,
			ts.DSCP,
			ts.EdgeHeaderRewrite,
			ts.GeoLimit,
			ts.GeoLimitCountries,
			ts.GeoLimitRedirectURL,
			ts.GeoProvider,
			ts.GlobalMaxMBPS,
			ts.GlobalMaxTPS,
			ts.HTTPBypassFQDN,
			ts.ID,
			ts.InfoURL,
			ts.InitialDispersion,
			ts.IPV6RoutingEnabled,
			ts.LastUpdated,
			ts.LogsEnabled,
			ts.LongDesc,
			ts.LongDesc1,
			ts.LongDesc2,
			ts.MaxDNSAnswers,
			ts.MidHeaderRewrite,
			ts.MissLat,
			ts.MissLong,
			ts.MultiSiteOrigin,
			ts.MultiSiteOriginAlgorithm,
			ts.OrgServerFQDN,
			ts.ProfileID,
			ts.Protocol,
			ts.QStringIgnore,
			ts.RangeRequestHandling,
			ts.RegexRemap,
			ts.RegionalGeoBlocking,
			ts.RemapText,
			ts.RoutingName,
			ts.SigningAlgorithm,
			ts.SSLKeyVersion,
			ts.TRRequestHeaders,
			ts.TRResponseHeaders,
			ts.TenantID,
			ts.TypeID,
			ts.XMLID,
		)
	}
	mock.ExpectQuery("SELECT").WillReturnRows(rows)
	v := url.Values{}
	v.Set("xmlId", "1")

	servers, err := getDeliveryServices(v, db)
	if err != nil {
		t.Errorf("getDeliveryServices expected: nil error, actual: %v", err)
	}

	if len(servers) != 2 {
		t.Errorf("getDeliveryServices expected: len(servers) == 1, actual: %v", len(servers))
	}

}

type SortableDeliveryServices []tcapi.DeliveryService

func (s SortableDeliveryServices) Len() int {
	return len(s)
}
func (s SortableDeliveryServices) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}
func (s SortableDeliveryServices) Less(i, j int) bool {
	a := *s[i].XMLID
	b := *s[j].XMLID
	return a < b
}
