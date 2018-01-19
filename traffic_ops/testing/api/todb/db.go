/*

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

package todb

import (
	"database/sql"
	"fmt"
	"os"

	"github.com/apache/incubator-trafficcontrol/lib/go-log"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/testing/api/config"
	"github.com/apache/incubator-trafficcontrol/traffic_ops/traffic_ops_golang/auth"
)

var (
	db *sql.DB
)

// OpenConnection ...
func OpenConnection(cfg *config.Config) (*sql.DB, error) {
	var err error
	sslStr := "require"
	if !cfg.TrafficOpsDB.SSL {
		sslStr = "disable"
	}

	db, err = sql.Open("postgres", fmt.Sprintf("postgres://%s:%s@%s/%s?sslmode=%s", cfg.TrafficOpsDB.User, cfg.TrafficOpsDB.Password, cfg.TrafficOpsDB.Hostname, cfg.TrafficOpsDB.Name, sslStr))

	if err != nil {
		log.Errorf("opening database: %v\n", err)
		return nil, fmt.Errorf("transaction failed: %s", err)
	}
	return db, err
}

// SetupTestData ...
func SetupTestData(cfg *config.Config, db *sql.DB) error {
	var err error
	err = SetupRoles(cfg, db)
	if err != nil {
		fmt.Printf("\nError setting up roles %s - %s, %v\n", cfg.TrafficOps.URL, cfg.TrafficOps.User, err)
		os.Exit(1)
	}

	err = SetupTmusers(cfg, db)
	if err != nil {
		fmt.Printf("\nError setting up tm_users %s - %s, %v\n", cfg.TrafficOps.URL, cfg.TrafficOps.User, err)
		os.Exit(1)
	}

	err = SetupTypes(cfg, db)
	if err != nil {
		fmt.Printf("\nError setting up types %s - %s, %v\n", cfg.TrafficOps.URL, cfg.TrafficOps.User, err)
		os.Exit(1)
	}
	return err
}

// SetupRoles ...
func SetupRoles(cfg *config.Config, db *sql.DB) error {

	log.Debugln("- role data")
	var err error

	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("transaction begin failed %v %v ", err, tx)
	}

	inserts := `
INSERT INTO role (id, name, description, priv_level) VALUES (1, 'disallowed','Block all access',0) ON CONFLICT DO NOTHING;
INSERT INTO role (id, name, description, priv_level) VALUES (2, 'read-only user','Block all access', 10) ON CONFLICT DO NOTHING;
INSERT INTO role (id, name, description, priv_level) VALUES (3, 'operations','Block all access', 20) ON CONFLICT DO NOTHING;
INSERT INTO role (id, name, description, priv_level) VALUES (4, 'admin','super-user', 30) ON CONFLICT DO NOTHING;
INSERT INTO role (id, name, description, priv_level) VALUES (5, 'portal','Portal User', 2) ON CONFLICT DO NOTHING;
INSERT INTO role (id, name, description, priv_level) VALUES (7, 'federation','Role for Secondary CZF', 15) ON CONFLICT DO NOTHING;
`
	res, err := tx.Exec(inserts)
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}

	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("commit failed %v %v", err, res)
	}
	return nil
}

// SetupTmusers ...
func SetupTmusers(cfg *config.Config, db *sql.DB) error {

	log.Debugln("- tm_user data")
	var err error

	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("transaction begin failed %v %v ", err, tx)
	}

	encryptedPassword, err := auth.DerivePassword(cfg.TrafficOps.UserPassword)
	if err != nil {
		return fmt.Errorf("password encryption failed %v", err)
	}
	itm := `INSERT INTO tm_user (username, local_passwd, confirm_local_passwd, role) VALUES ('admin','` + encryptedPassword + `','` + encryptedPassword + `', 4)`
	res, err := tx.Exec(itm)
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("commit failed %v %v", err, res)
	}
	return nil
}

// SetupTypes ...
func SetupTypes(cfg *config.Config, db *sql.DB) error {

	log.Debugln("- type data")
	var err error

	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("transaction begin failed %v %v ", err, tx)
	}

	inserts := `
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (1, 'EDGE', 'Edge Cache', 'server', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (2, 'MID', 'Mid Tier Cache', 'server', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (3, 'ORG', 'Origin', 'server', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (4, 'CCR', 'Comcast Content Router', 'server', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (6, 'EDGE_LOC', 'Edge Logical Location', 'cachegroup', '2015-03-03 17:18:08.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (7, 'MID_LOC', 'Mid Logical Location', 'cachegroup', '2015-03-03 17:18:08.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (8, 'HTTP', 'HTTP Content Routing', 'deliveryservice', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (9, 'DNS', 'DNS Content Routing', 'deliveryservice', '2012-09-17 21:41:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (11, 'HTTP_NO_CACHE', 'HTTP Content Routing, no caching', 'deliveryservice', '2012-10-03 13:33:40.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (13, 'HTTP_LIVE', 'HTTP Content routing cache in RAM', 'deliveryservice', '2012-10-03 22:27:14.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (15, 'RASCAL', 'Rascal health polling & reporting', 'server', '2013-04-10 21:02:55.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (18, 'HOST_REGEXP', 'Host header regular expression', 'regex', '2013-08-22 15:04:31.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (19, 'PATH_REGEXP', 'URL path regular expression', 'regex', '2013-08-22 15:04:31.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (20, 'HEADER_REGEXP', 'HTTP header regular expression', 'regex', '2013-08-22 15:04:31.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (21, 'A_RECORD', 'Static DNS A entry', 'staticdnsentry', '2013-10-23 15:28:31.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (22, 'AAAA_RECORD', 'Static DNS AAAA entry', 'staticdnsentry', '2013-10-23 15:28:31.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (23, 'CNAME_RECORD', 'Static DNS CNAME entry', 'staticdnsentry', '2013-10-29 13:01:51.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (24, 'HTTP_LIVE_NATNL', 'HTTP Content routing, RAM cache, National', 'deliveryservice', '2013-11-22 15:01:21.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (26, 'DNS_LIVE_NATNL', 'DNS Content routing, RAM cache, National', 'deliveryservice', '2014-05-28 18:31:11.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (27, 'DNS_LIVE', 'DNS Content routing, RAM cache, Local', 'deliveryservice', '2014-05-28 18:31:11.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (31, 'CHECK_EXTENSION_BOOL', 'Extension for checkmark in Server Check', 'to_extension', '2015-02-04 18:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (32, 'CHECK_EXTENSION_NUM', 'Extension for int value in Server Check', 'to_extension', '2015-02-04 18:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (33, 'CHECK_EXTENSION_OPEN_SLOT', 'Open slot for check in Server Status', 'to_extension', '2015-02-04 18:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (34, 'CONFIG_EXTENSION', 'Extension for additional configuration file', 'to_extension', '2015-02-04 18:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (35, 'STATISTIC_EXTENSION', 'Extension source for 12M graphs', 'to_extension', '2015-02-04 18:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (41, 'RIAK', 'Riak keystore', 'server', '2015-03-03 17:18:08.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (68, 'TRAFFIC_STATS', 'traffic_stats server', 'server', '2015-05-13 15:56:10.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (69, 'INFLUXDB', 'influxDb server', 'server', '2015-05-13 15:56:10.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (70, 'ANY_MAP', 'No Content Routing - arbitrary remap at the edge, no Traffic Router config', 'deliveryservice', '2015-07-01 15:25:41.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (71, 'ORG_LOC', 'Origin Logical Site', 'cachegroup', '2015-07-01 15:25:41.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (125, 'RESOLVE4', 'federation type resolve4', 'federation', '2015-12-14 16:50:24.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (126, 'RESOLVE6', 'federation type resolve6', 'federation', '2015-12-14 16:50:24.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (147, 'LOGSTASH', 'data type for Logstash servers', 'server', '2016-01-29 18:45:12.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (148, 'KAFKAZOO', 'Data type for Kafka Zookeeper nodes', 'server', '2016-01-29 18:58:07.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (149, 'KAFKA', 'Data type for Kafka broker nodes', 'server', '2016-01-29 18:59:22.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (193, 'STEERING', 'Steering Delivery Service', 'deliveryservice', '2016-07-12 16:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (194, 'STEERING_REGEXP', 'Steering target filter regular expression', 'regex', '2016-07-12 16:03:30.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (195, 'TRAFFIC_PORTAL', 'Traffic Portal server', 'server', '2016-07-19 02:26:49.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (197, 'TRAFFIC_ANALYTICS', 'Servers used for traffic analytics', 'server', '2016-09-07 17:18:42.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (253, 'TRAFFIC_OPS', 'Traffic Ops server', 'server', '2017-02-08 15:05:58.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (254, 'TRAFFIC_OPS_DB', 'Traffic Ops database server', 'server', '2017-02-08 15:07:15.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (255, 'CLIENT_STEERING', 'Client-Controlled Steering Delivery Service', 'deliveryservice', '2017-03-13 17:47:01.000000');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (295, 'TR_LOC', 'Traffic Router Logical Site', 'cachegroup', '2017-06-28 15:57:30.943417');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (376, 'STEERING_WEIGHT', 'Weighted steering target', 'steering_target', '2017-07-17 16:59:44.713317');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (377, 'STEERING_ORDER', 'Ordered steering target', 'steering_target', '2017-07-17 16:59:44.718842');
INSERT INTO type (id, name, description, use_in_table, last_updated) VALUES (584, 'INFLUXDB_TELEGRAF', 'influxDb server - telegraf', 'server', '2017-11-14 20:57:30.381165');
`
	res, err := tx.Exec(inserts)
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}

	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("commit failed %v %v", err, res)
	}
	return nil
}

// Teardown - ensures that the data is cleaned up for a fresh run
func Teardown(cfg *config.Config, db *sql.DB) error {
	log.Debugln("Tearing down data")
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("transaction begin failed %v %v ", err, tx)
	}

	res, err := tx.Exec("DELETE FROM TO_EXTENSION")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}

	res, err = tx.Exec("DELETE FROM STATICDNSENTRY")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM JOB")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM JOB_AGENT")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM JOB_STATUS")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM LOG")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM ASN")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM DELIVERYSERVICE_TMUSER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM TM_USER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM ROLE")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM DELIVERYSERVICE_REGEX")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM REGEX")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM DELIVERYSERVICE_SERVER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM DELIVERYSERVICE")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM SERVER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM PHYS_LOCATION")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM REGION")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM DIVISION")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM PROFILE")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM PARAMETER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM PROFILE_PARAMETER")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM CACHEGROUP")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM TYPE")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM STATUS")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM SNAPSHOT")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM CDN")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}
	res, err = tx.Exec("DELETE FROM TENANT")
	if err != nil {
		return fmt.Errorf("exec failed %v %v", err, res)
	}

	err = tx.Commit()
	if err != nil {
		return fmt.Errorf("commit failed %v %v", err, res)
	}
	return err
}
