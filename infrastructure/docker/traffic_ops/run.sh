#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# Script for running the Dockerfile for Traffic Ops.
# The Dockerfile sets up a Docker image which can be used for any new Traffic Ops container;
# This script, which should be run when the container is run (it's the ENTRYPOINT), will configure the container.
#
# The following environment variables must be set, ordinarily by `docker run -e` arguments:
#   DB_SERVER
#   POSTGRES_PASSWORD
#   POSTGRES_PORT
#   DB_USER
#   TO_HOST
#   TO_EMAIL
#   TP_HOST
#   TP_EMAIL
#   TO_SECRET
#   RIAK_USER
#   RIAK_PASSWORD

# Check that env vars are set
envvars=( DB_SERVER POSTGRES_PASSWORD DB_PORT DB_USER TO_HOST TO_EMAIL TP_HOST TP_EMAIL TO_SECRET RIAK_USER RIAK_PASSWORD )
for v in $envvars
do
	if [[ -z $$v ]]; then echo "$v is unset"; exit 1; fi
done

cd /opt/traffic_ops/app || echo "NO /opt/traffic_ops/app found" && exit 1

cat >app/conf/production/database.conf <<ENDOFDATABASECONF
{
   "dbname" : "traffic_ops"
   "description" : "Pg database on localhost:5432",
   "hostname" : "$DB_SERVER",
   "password" : "$DB_ROOT_PASS",
   "port" : "$DB_PORT",
   "type" : "Pg",
   "user" : "$DB_USER",
}
ENDOFDATABASECONF

cat > conf/cdn.conf <<ENDOFCDNCONF
{
    "hypnotoad" : {
        "listen" : [
            "https://[::]:60443?cert=/etc/pki/tls/certs/localhost.crt&key=/etc/pki/tls/private/localhost.key&verify=0x00&ciphers=AES128-GCM-SHA256:HIGH:!RC4:!MD5:!aNULL:!EDH:!ED"
        ],
        "user" : "trafops",
        "group" : "trafops",
        "heartbeat_timeout" : 20,
        "pid_file" : "/var/run/traffic_ops.pid",
        "workers" : 12
    },
    "traffic_ops_golang" : {
        "insecure": false,
        "port" : "443",
        "proxy_timeout" : 60,
        "proxy_keep_alive" : 60,
        "proxy_tls_timeout" : 60,
        "proxy_read_header_timeout" : 60,
        "read_timeout" : 60,
        "read_header_timeout" : 60,
        "write_timeout" : 60,
        "idle_timeout" : 60,
        "log_location_error": "/var/log/traffic_ops/error.log",
        "log_location_warning": "/var/log/traffic_ops/warning.log",
        "log_location_info": "/var/log/traffic_ops/info.log",
        "log_location_debug": "/var/log/traffic_ops/debug.log",
        "log_location_event": "/var/log/traffic_ops/event.log",
        "max_db_connections": 20,
        "backend_max_connections": {
            "mojolicious": 4
        }
    },
    "cors" : {
        "access_control_allow_origin" : "*"
    },
    "to" : {
        "base_url" : "https://$TO_HOST",
        "email_from" : "$TO_EMAIL",
        "no_account_found_msg" : "A Traffic Ops user account is required for access. Please contact your Traffic Ops user administrator."
    },
    "portal" : {
        "base_url" : "https://$TP_HOST",
        "email_from" : "$TP_EMAIL",
        "pass_reset_path" : "user",
        "user_register_path" : "user"
    },
    "secrets" : [
        "$TO_SECRET"
    ],
    "geniso" : {
        "iso_root_path" : "/opt/traffic_ops/app/public"
    },
    "inactivity_timeout" : 60
}
ENDOFCDNCONF

cat >app/conf/production/riak.conf <<ENDOFRIAKCONF
{
	"user": "$RIAK_USER",
	"password": "$RIAK_PASSWORD"
}
ENDOFRIAKCONF

app/local/bin/hypnotoad script/cdn
exec tail -f /var/log/traffic_ops/traffic_ops.log

