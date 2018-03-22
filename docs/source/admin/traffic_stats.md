Traffic Stats Administration
============================

Traffic Stats consists of three seperate components: Traffic Stats,
InfluxDB, and Grafana. See below for information on installing and
configuring each component as well as configuring the integration
between the three and Traffic Ops.

Installation
------------

**Installing Traffic Stats:**

> -   See the
>     [downloads](https://trafficcontrol.apache.org/downloads/index.html)
>     page for Traffic Control to get the lastest release.
> -   Follow our build
>     [intructions](https://github.com/apache/incubator-trafficcontrol/tree/master/build)
>     to generate an RPM.
> -   Copy the RPM to your server
> -   perform the following command: `sudo rpm -ivh <traffic_stats rpm>`

**Installing InfluxDB:**

> **As of Traffic Stats 1.8.0, InfluxDb 1.0.0 or higher is required. For
> InfluxDb versions less than 1.0.0 use Traffic Stats 1.7.x**
>
> In order to store traffic stats data you will need to install
> [InfluxDB](https://docs.influxdata.com/influxdb/latest/introduction/installation/).
> While not required, it is recommended to use some sort of high
> availability option like [Influx
> enterprise](https://portal.influxdata.com/), [Influxdb
> Relay](https://github.com/influxdata/influxdb-relay), or another [high
> availability option](https://www.influxdata.com/high-availability/).

**Installing Grafana:**

> Grafana is used to display Traffic Stats/InfluxDB data in Traffic Ops.
> Grafana is typically run on the same server as Traffic Stats but this
> is not a requirement. Grafana can be installed on any server that can
> access InfluxDB and can be accessed by Traffic Ops. Documentation on
> installing Grafana can be found on the [Grafana
> website](http://docs.grafana.org/installation/).

Configuration
-------------

**Configuring Traffic Stats:**

> Traffic Stats' configuration file can be found in
> /opt/traffic\_stats/conf/traffic\_stats.cfg. The following values need
> to be configured:
>
> > -   *toUser:* The user used to connect to Traffic Ops
> > -   *toPasswd:* The password to use when connecting to Traffic Ops
> > -   *toUrl:* The URL of the Traffic Ops server used by Traffic Stats
> > -   *influxUser:* The user to use when connecting to InfluxDB (if
> >     configured on InfluxDB, else leave default)
> > -   *influxPassword:* That password to use when connecting to
> >     InfluxDB (if configured, else leave blank)
> > -   *pollingInterval:* The interval at which Traffic Monitor is
> >     polled and stats are stored in InfluxDB
> > -   *statusToMon:* The status of Traffic Monitor to poll (poll
> >     ONLINE or OFFLINE traffic monitors)
> > -   *seelogConfig:* The absolute path of the seelong config file
> > -   *dailySummaryPollingInterval:* The interval, in seconds, at
> >     which Traffic Stats checks to see if daily stats need to be
> >     computed and stored.
> > -   *cacheRetentionPolicy:* The default retention policy for cache
> >     stats
> > -   *dsRetentionPolicy:* The default retention policy for
> >     deliveryservice stats
> > -   *dailySummaryRetentionPolicy:* The retention policy to be used
> >     for the daily stats
> > -   *influxUrls:* An array of influxdb hosts for Traffic Stats to
> >     write stats to.

**Configuring InfluxDB:**

> As mentioned above, it is recommended that InfluxDb be running in some
> sort of high availability configuration. There are several ways to
> achieve high availabilty so it is best to consult the high
> availability options on the [InfuxDB
> website](https://www.influxdata.com/high-availability/).
>
> Once InfluxDB is installed and configured, databases and retention
> policies need to be created. Traffic Stats writes to three different
> databases: cache\_stats, deliveryservice\_stats, and daily\_stats.
> More information about the databases and what data is stored in each
> can be found on the [overview](../overview/traffic_stats.html) page.
>
> To easily create databases, retention policies, and continuous
> queries, run create\_ts\_databases from the
> /opt/traffic\_stats/influxdb\_tools directory on your Traffic Stats
> server. See the [InfluxDb Tools](traffic_stats.html#influxdb-tools)
> section below for more information.

**Configuring Grafana:**

> In Traffic Ops the Health -&gt; Graph View tab can be configured to
> display grafana graphs using influxDb data. In order for this to work
> correctly, you will need two things 1) a parameter added to traffic
> ops with the graph URL (more information below) and 2) the graphs
> created in grafana. See below for how to create some simple graphs in
> grafana. These instructions assume that InfluxDB has been configured
> and that data has been written to it. If this is not true, you will
> not see any graphs.
>
> -   Login to grafana as an admin user <http://grafana_url:3000/login>
> -   Choose Data Sources and then Add New
> -   Enter the necessary information to configure your data source
> -   Click on the 'Home' dropdown at the top of the screen and choose
>     New at the bottom
> -   Click on the green menu bar (with 3 lines) at the top and choose
>     Add Panel -&gt; Graph
> -   Where it says 'No Title (click here)' click and choose edit
> -   Choose your data source at the bottom
> -   You can have grafana help you create a query, or you can create
>     your own. Here is a sample query:
>
>     > `SELECT sum(value)*1000 FROM "monthly"."bandwidth.cdn.1min" WHERE $timeFilter GROUP BY time(60s), cdn`
>
> -   Once you have the graph the way you want it, click the 'Save
>     Dashboard' button at the top
> -   You should now have a new saved graph

> In order for Traffic Ops users to see Grafana graphs, Grafana will
> need to allow anonymous access. Information on how to configure
> anonymous access can be found on the configuration page of the
> [Grafana
> Website](http://docs.grafana.org/installation/configuration/#authanonymous).
>
> Traffic Ops uses custom dashboards to display information about
> individual delivery services or cache groups. In order for the custom
> graphs to display correctly, the
> [[traffic\_ops]()\*.js](https://github.com/apache/incubator-trafficcontrol/blob/master/traffic_stats/grafana/)
> files need to be in the `/usr/share/grafana/public/dashboards/`
> directory on the grafana server. If your Grafana server is the same as
> your Traffic Stats server the RPM install process will take care of
> putting the files in place. If your grafana server is different from
> your Traffic Stats server, you will need to manually copy the files to
> the correct directory.
>
> More information on custom scripted graphs can be found in the
> [scripted dashboards](http://docs.grafana.org/reference/scripting/)
> section of the Grafana documentation.

**Configuring Traffic Ops for Traffic Stats:**

> -   The influxDb servers need to be added to Traffic Ops with profile
>     = InfluxDB. Make sure to use port 8086 in the configuration.
> -   The traffic stats server should be added to Traffic Ops with
>     profile = Traffic Stats.
> -   Parameters for which stats will be collected are added with the
>     release, but any changes can be made via parameters that are
>     assigned to the Traffic Stats profile.

**Configuring Traffic Ops to use Grafana Dashboards**

> To configure Traffic Ops to use Grafana Dashboards, you need to enter
> the following parameters and assign them to the GLOBAL profile. This
> assumes you followed the above instructions to install and configure
> InfluxDB and Grafana. You will need to place
> 'cdn-stats','deliveryservice-stats', and 'daily-summary' with the name
> of your dashboards.
>
>   parameter name                                                                                           parameter value
>   -------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>   all\_graph\_url                                                                                          <https://>&lt;grafana\_url&gt;/dashboard/db/deliveryservice-stats
>   cachegroup\_graph\_url                                                                                   <https://>&lt;grafanaHost&gt;/dashboard/script/traffic\_ops\_cachegroup.js?which=
>   deliveryservice\_graph\_url                                                                              <https://>&lt;grafanaHost&gt;/dashboard/script/traffic\_ops\_devliveryservice.js?which=
>   server\_graph\_url                                                                                       <https://>&lt;grafanaHost&gt;/dashboard/script/traffic\_ops\_server.js?which=
>   visual\_status\_panel\_1                                                                                 <https://>&lt;grafanaHost&gt;/dashboard-solo/db/cdn-stats?panelId=2&fullscreen&from=now-24h&to=now-60s
>   visual\_status\_panel\_2                                                                                 <https://>&lt;grafanaHost&gt;/dashboard-solo/db/cdn-stats?panelId=1&fullscreen&from=now-24h&to=now-60s
>   daily\_bw\_url                                                                                           <https://>&lt;grafanaHost&gt;/dashboard-solo/db/daily-summary?panelId=1&fullscreen&from=now-3y&to=now
>   daily\_served\_url                                                                                       <https://>&lt;grafanaHost&gt;/dashboard-solo/db/daily-summary?panelId=2&fullscreen&from=now-3y&to=now
>
InfluxDb Tools
--------------

Under the Traffic Stats source directory there is a directory called
influxdb\_tools. These tools are meant to be used as one-off scripts to
help a user quickly get new databases and continuous queries setup in
influxdb. They are specific for traffic stats and are not meant to be
generic to influxdb. Below is an brief description of each script along
with how to use it.

**create/create\_ts\_databases.go**

:   This script creates all
    [databases](https://docs.influxdata.com/influxdb/latest/concepts/key_concepts/#database),
    [retention
    policies](https://docs.influxdata.com/influxdb/latest/concepts/key_concepts/#retention-policy),
    and [continuous
    queries](https://docs.influxdata.com/influxdb/v0.11/query_language/continuous_queries/)
    required by traffic stats.

    **How to use create\_ts\_databases:**

    Pre-Requisites:

    > 1.  Go 1.7 or later
    > 2.  configured \$GOPATH (e.g. export GOPATH=\~/go)

    Using create\_ts\_databases.go

    > 1.  go to the traffic\_stats/influxdb\_tools/create directory
    > 2.  build it by running `go build create_ts_databases.go` or
    >     simply `go build`
    > 3.  
    >
    >     Run it:
    >
    >     :   -   `./create_ts_databases -help` or `./create -help`
    >         -   
    >
    >             optional flags:
    >
    >             :   -   url - The influxdb url and port
    >                 -   replication - The number of nodes in the
    >                     cluster
    >                 -   user - The user to use
    >                 -   password - The password to use
    >
    >         -   example:
    >             `./create_ts_databases -url=localhost:8086 -replication=3 -user=joe -password=mysecret`
    >             or
    >             `./create -url=localhost:8086 -replication=3 -user=joe -password=mysecret`
    >
**sync\_ts\_databases**

:   This script is used to sync one influxdb environment to another.
    Only data from continuous queries is synced as it is downsampled
    data and much smaller in size than syncing raw data. Possible use
    cases are syncing from Production to Development or Syncing a new
    cluster once brought online.

    **How to use sync\_ts\_databases:**

    Pre-Requisites:

    > 1.  Go 1.7 or later
    > 2.  configured \$GOPATH (e.g. export GOPATH=\~/go)

    Using sync\_ts\_databases.go:

    > 1.  go to the traffic\_stats/influxdb\_tools/create directory
    > 2.  build it by running `go build sync_ts_databases.go` or simply
    >     `go build`
    > 3.  
    >
    >     Run it
    >
    >     :   -   `./sync_ts_databases -help` or `./sync -help`
    >         -   
    >
    >             required flags:
    >
    >             :   -   source-url - The URL of the source database
    >                 -   target-url - The URL of the target database
    >
    >         -optional flags:
    >
    >         :   -   database - The database to sync (default = sync
    >                 all databases)
    >             -   days - Days in the past to sync (default = sync
    >                 all data)
    >             -   source-user - The user of the source database
    >             -   source-pass - The password for the source database
    >             -   target-user - The user of the target database
    >             -   target-pass - The password for the target database
    >
    >         -   example:
    >             ./sync -source-url=http://idb-01.foo.net:8086 -target-url=http://idb-01.foo.net:8086 -database=cache\_stats -days=7 -source-user=admin source-pass=mysecret
    >

