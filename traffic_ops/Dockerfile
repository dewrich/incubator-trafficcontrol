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

############################################################
# Dockerfile to build Traffic Ops container images
# Based on CentOS 7.2
############################################################

# Base stage installs rpms needed for both building and runtime
FROM centos:7 as base
MAINTAINER Dan Kirkwood

RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm
RUN yum -y install \
    libcap\
    libcurl\
    libcurl-devel\
    libidn-devel\
    libpcap-devel\
    mkisofs\
    openssl-devel\
    perl\
    perl-Crypt-ScryptKDF\
    perl-DBD-Pg\
    perl-DBI\
    perl-Digest-SHA1\
    perl-JSON\
    perl-TermReadKey\
    perl-Test-CPAN-Meta\
    perl-WWW-Curl\
    perl-core\
    perl-libwww-perl\
    postgresql96\
    postgresql96-devel

# Build stage gets traffic ops source in place and installs perl modules using carton
FROM base as build
 
RUN yum -y install \
    cpanminus\
    expat-devel\
    gcc-c++

RUN cpanm Carton
ADD app /opt/traffic_ops/app
WORKDIR /opt/traffic_ops/app
RUN POSTGRES_HOME=/usr/pgsql-9.6 /usr/local/bin/carton || cat /root/.cpanm/work/*/build.log


# Trafficops Perl stage runs hypnotoad
FROM base as traffic_ops_perl

COPY --from=build /opt/traffic_ops /opt/traffic_ops
