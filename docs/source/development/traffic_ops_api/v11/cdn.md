CDN
===

/api/1.1/cdns
-------------

**GET /api/1.1/cdns**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `id`            | strin | CDN id.                                    |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `name`          | strin | CDN name.                                  |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `dnssecEnabled` | > boo | DNSSEC enabled.                            |
> |                 | l     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `lastUpdated`   | strin |                                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "id": "1"
>               "name": "over-the-top",
>               "dnssecEnabled": false,
>               "lastUpdated": "2014-10-02 08:22:43"
>            },
>            {
>               "id": "2"
>               "name": "cdn2",
>               "dnssecEnabled": true,
>               "lastUpdated": "2014-10-02 08:22:43"
>            }
>         ]
>     }

| 

**GET /api/1.1/cdns/:id**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-----------+----------+---------------------------------------------+
> | Name      | Required | Description                                 |
> +===========+==========+=============================================+
> | > `id`    | > yes    | CDN id.                                     |
> +-----------+----------+---------------------------------------------+
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `id`            | strin | CDN id.                                    |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `name`          | strin | CDN name.                                  |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `dnssecEnabled` | > boo | DNSSEC enabled.                            |
> |                 | l     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `lastUpdated`   | strin |                                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "id": "2"
>               "name": "cdn2",
>               "dnssecEnabled": false,
>               "lastUpdated": "2014-10-02 08:22:43"
>            }
>         ]
>     }

| 

**GET /api/1.1/cdns/name/:name**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-----------+----------+---------------------------------------------+
> | Name      | Required | Description                                 |
> +===========+==========+=============================================+
> | > `name`  | > yes    | CDN name.                                   |
> +-----------+----------+---------------------------------------------+
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `id`            | strin | CDN id.                                    |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `name`          | strin | CDN name.                                  |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `dnssecEnabled` | > boo | DNSSEC enabled.                            |
> |                 | l     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `lastUpdated`   | strin |                                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "id": "2"
>               "name": "cdn2",
>               "dnssecEnabled": false,
>               "lastUpdated": "2014-10-02 08:22:43"
>            }
>         ]
>     }

| 

Health
------

**GET /api/1.1/cdns/health**

> Retrieves the health of all locations (cache groups) for all CDNs.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                         Type             Description
>   --------------------------------- ---------------- ----------------------------------------------------------------------------------------
>   `totalOnline`                     int              Total number of online caches across all CDNs.
>   `totalOffline`                    int              Total number of offline caches across all CDNs.
>   `cachegroups`                     array            A collection of cache groups.
>   `>online`                         int              The number of online caches for the cache group
>   `>offline`                        int              The number of offline caches for the cache group.
>   `>name`                           string           Cache group name.
>
> **Response Example** :
>
>     {
>      "response": {
>         "totalOnline": 148,
>         "totalOffline": 0,
>         "cachegroups": [
>            {
>               "online": 8,
>               "offline": 0,
>               "name": "us-co-denver"
>            },
>            {
>               "online": 7,
>               "offline": 0,
>               "name": "us-de-newcastle"
>            }
>         ]
>      },
>     }

| 

**GET /api/1.1/cdns/:name/health**

> Retrieves the health of all locations (cache groups) for a given CDN.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- -------------------------------------------------------------
>   `name`                yes           
>
> **Response Properties**
>
>   Parameter                         Type             Description
>   --------------------------------- ---------------- ----------------------------------------------------------------------------------------
>   `totalOnline`                     int              Total number of online caches across the specified CDN.
>   `totalOffline`                    int              Total number of offline caches across the specified CDN.
>   `cachegroups`                     array            A collection of cache groups.
>   `>online`                         int              The number of online caches for the cache group
>   `>offline`                        int              The number of offline caches for the cache group.
>   `>name`                           string           Cache group name.
>
> **Response Example** :
>
>     {
>      "response": {
>         "totalOnline": 148,
>         "totalOffline": 0,
>         "cachegroups": [
>            {
>               "online": 8,
>               "offline": 0,
>               "name": "us-co-denver"
>            },
>            {
>               "online": 7,
>               "offline": 0,
>               "name": "us-de-newcastle"
>            }
>         ]
>      },
>     }

| 

**GET /api/1.1/cdns/usage/overview**

> Retrieves the high-level CDN usage metrics.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `currentGbps`                          number          
>   `tps`                                  int             
>   `maxGbps`                              int             
>
> **Response Example** :
>
>     {
>          "response": {
>             "currentGbps": 149.368167,
>             "tps": 36805,
>             "maxGbps": 3961
>          }
>     }

**GET /api/1.1/cdns/capacity**

> Retrieves the aggregate capacity percentages of all locations (cache
> groups) for a given CDN.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                                                Type                   Description
>   -------------------------------------------------------- ---------------------- -----------------------------------------------------------------------------------------------------------------------
>   `availablePercent`                                       number                 
>   `unavailablePercent`                                     number                 
>   `utilizedPercent`                                        number                 
>   `maintenancePercent`                                     number                 
>
> **Response Example** :
>
>     {
>          "response": {
>             "availablePercent": 89.0939840205533,
>             "unavailablePercent": 0,
>             "utilizedPercent": 10.9060020300395,
>             "maintenancePercent": 0.0000139494071146245
>          }
>     }

| 

Routing
-------

**GET /api/1.1/cdns/routing**

> Retrieves the aggregate routing percentages of all locations (cache
> groups) for a given CDN.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                        Type             Description
>   -------------------------------- ---------------- --------------------------------------------------------------------------
>   `staticRoute`                    number           Used pre-configured DNS entries.
>   `miss`                           number           No location available for client IP.
>   `geo`                            number           Used 3rd party geo-IP mapping.
>   `err`                            number           Error localizing client IP.
>   `cz`                             number           Used Coverage Zone geo-IP mapping.
>   `dsr`                            number           Overflow traffic sent to secondary CDN.
>
> **Response Example** :
>
>     {
>           "response": {
>              "staticRoute": 0,
>              "miss": 0,
>              "geo": 37.8855391018869,
>              "err": 0,
>              "cz": 62.1144608981131,
>              "dsr": 0
>           }
>      }

| 

Metrics
-------

**GET
/api/1.1/cdns/metric\_types/:metric/start\_date/:start/end\_date/:end**

> Retrieves edge metrics of one or all locations (cache groups).
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                     Required        Description
>   ------------------------ --------------- --------------------------------------
>   `metric_type`            yes             ooff, origin\_tps
>   `start`                  yes             UNIX time, yesterday, now
>   `end`                    yes             UNIX time, yesterday, now
>
> **Response Properties**
>
>   Parameter                                      Type                Description
>   ---------------------------------------------- ------------------- -----------------------------
>   `stats`                                        hash                
>   `>count`                                       string              
>   `>98thPercentile`                              string              
>   `>min`                                         string              
>   `>max`                                         string              
>   `>5thPercentile`                               string              
>   `>95thPercentile`                              string              
>   `>mean`                                        string              
>   `>sum`                                         string              
>   `data`                                         array               
>   `>time`                                        int                 
>   `>value`                                       number              
>   `label`                                        string              
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "stats": {
>               "count": 1,
>               "98thPercentile": 1668.03,
>               "min": 1668.03,
>               "max": 1668.03,
>               "5thPercentile": 1668.03,
>               "95thPercentile": 1668.03,
>               "mean": 1668.03,
>               "sum": 1668.03
>            },
>            "data": [
>               [
>                  1425135900000,
>                  1668.03
>               ],
>               [
>                  1425136200000,
>                  null
>               ]
>            ],
>            "label": "Origin TPS"
>         }
>      ],
>     }

| 

Domains
-------

**GET /api/1.1/cdns/domains**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                                                Type                   Description
>   -------------------------------------------------------- ---------------------- -----------------------------------------------------------------------------------------------------------------------
>   `profileId`                                              string                 
>   `parameterId`                                            string                 
>   `profileName`                                            string                 
>   `profileDescription`                                     string                 
>   `domainName`                                             string                 
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "profileId": "5",
>            "parameterId": "404",
>            "profileName": "CR_FOO",
>            "profileDescription": "Content Router for foo.domain.net",
>            "domainName": "foo.domain.net"
>         },
>         {
>            "profileId": "8",
>            "parameterId": "405",
>            "profileName": "CR_BAR",
>            "profileDescription": "Content Router for bar.domain.net",
>            "domainName": "bar.domain.net"
>         }
>      ],
>     }

| 

Topology
--------

**GET /api/1.1/cdns/:cdn\_name/configs**

> Retrieves CDN config information based upon the provided cdn name.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name              Required      Description
>   ----------------- ------------- ----------------------------
>   `cdn_name`        yes           Your cdn name or, all
>
> **Response Properties**
>
>   Parameter                                Type            Description
>   ---------------------------------------- --------------- --------------------------------------------------------------------------------
>   `id`                                     string          
>   `value`                                  string          
>   `name`                                   string          
>   `config_file`                            string          
>
> **Response Example** :
>
>     TBD

| 

**GET /api/1.1/cdns/:name/configs/monitoring**

> Retrieves CDN monitoring information.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +----------+----------+-------------+
> | Name     | Required | Description |
> +==========+==========+=============+
> | `name`   | yes      | > CDN name  |
> +----------+----------+-------------+
>
> **Response Properties**
>
>   Parameter                                                                                                                                                                                                                                                             Type                                            Description
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------- -------------------------------------------------------------------------------------------------------------
>   `trafficServers`                                                                                                                                                                                                                                                      array                                           A collection of Traffic Servers.
>   `>profile`                                                                                                                                                                                                                                                            string                                          
>   `>ip`                                                                                                                                                                                                                                                                 string                                          
>   `>status`                                                                                                                                                                                                                                                             string                                          
>   `>cacheGroup`                                                                                                                                                                                                                                                         string                                          
>   `>ip6`                                                                                                                                                                                                                                                                string                                          
>   `>port`                                                                                                                                                                                                                                                               int                                             
>   `>hostName`                                                                                                                                                                                                                                                           string                                          
>   `>fqdn`                                                                                                                                                                                                                                                               string                                          
>   `>interfaceName`                                                                                                                                                                                                                                                      string                                          
>   `>type`                                                                                                                                                                                                                                                               string                                          
>   `>hashId`                                                                                                                                                                                                                                                             string                                          
>   `cacheGroups`                                                                                                                                                                                                                                                         array                                           A collection of cache groups.
>   `>coordinates`                                                                                                                                                                                                                                                        hash                                            
>   `>>longitude`                                                                                                                                                                                                                                                         number                                          
>   `>>latitude`                                                                                                                                                                                                                                                          number                                          
>   `>name`                                                                                                                                                                                                                                                               string                                          
>   `config`                                                                                                                                                                                                                                                              hash                                            
>   `>hack.ttl`                                                                                                                                                                                                                                                           int                                             
>   `>tm.healthParams.polling.url`                                                                                                                                                                                                                                        string                                          
>   `>tm.dataServer.polling.url`                                                                                                                                                                                                                                          string                                          
>   `>health.timepad`                                                                                                                                                                                                                                                     int                                             
>   `>tm.polling.interval`                                                                                                                                                                                                                                                int                                             
>   `>health.threadPool`                                                                                                                                                                                                                                                  int                                             
>   `>health.polling.interval`                                                                                                                                                                                                                                            int                                             
>   `>health.event-count`                                                                                                                                                                                                                                                 int                                             
>   `>tm.crConfig.polling.url`                                                                                                                                                                                                                                            number                                          
>   `>CDN_name`                                                                                                                                                                                                                                                           number                                          
>   `trafficMonitors`                                                                                                                                                                                                                                                     array                                           A collection of Traffic Monitors.
>   `>profile`                                                                                                                                                                                                                                                            string                                          
>   `>location`                                                                                                                                                                                                                                                           string                                          
>   `>ip`                                                                                                                                                                                                                                                                 string                                          
>   `>status`                                                                                                                                                                                                                                                             string                                          
>   `>ip6`                                                                                                                                                                                                                                                                string                                          
>   `>port`                                                                                                                                                                                                                                                               int                                             
>   `>hostName`                                                                                                                                                                                                                                                           string                                          
>   `>fqdn`                                                                                                                                                                                                                                                               string                                          
>   `deliveryServices`                                                                                                                                                                                                                                                    array                                           A collection of delivery services.
>   `>xmlId`                                                                                                                                                                                                                                                              string                                          
>   `>totalTpsThreshold`                                                                                                                                                                                                                                                  int                                             
>   `>status`                                                                                                                                                                                                                                                             string                                          
>   `>totalKbpsThreshold`                                                                                                                                                                                                                                                 int                                             
>   `profiles`                                                                                                                                                                                                                                                            array                                           A collection of profiles.
>   `>parameters`                                                                                                                                                                                                                                                         hash                                            
>   `>>health.connection.timeout`                                                                                                                                                                                                                                         int                                             
>   `>>health.polling.url`                                                                                                                                                                                                                                                string                                          
>   `>>health.threshold.queryTime`                                                                                                                                                                                                                                        int                                             
>   `>>history.count`                                                                                                                                                                                                                                                     int                                             
>   `>>health.threshold.availableBandwidthInKbps`                                                                                                                                                                                                                         string                                          
>   `>>health.threshold.loadavg`                                                                                                                                                                                                                                          string                                          
>   `>name`                                                                                                                                                                                                                                                               string                                          
>   `>type`                                                                                                                                                                                                                                                               string                                          
>
> **Response Example** :
>
>     TBD

| 

**GET /api/1.1/cdns/:name/configs/routing**

> Retrieves CDN routing information.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name          Required      Description
>   ------------- ------------- ----------------
>   `name`        yes           
>
> **Response Properties**
>
>   Parameter                                                                                                                             Type                                Description
>   ------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------- ------------------------------------------------------------------------------------------------------------------------------
>   `trafficServers`                                                                                                                      array                               A collection of Traffic Servers.
>   `>profile`                                                                                                                            string                              
>   `>ip`                                                                                                                                 string                              
>   `>status`                                                                                                                             string                              
>   `>cacheGroup`                                                                                                                         string                              
>   `>ip6`                                                                                                                                string                              
>   `>port`                                                                                                                               int                                 
>   `>deliveryServices`                                                                                                                   array                               
>   `>>xmlId`                                                                                                                             string                              
>   `>>remaps`                                                                                                                            array                               
>   `>>hostName`                                                                                                                          string                              
>   `>fqdn`                                                                                                                               string                              
>   `>interfaceName`                                                                                                                      string                              
>   `>type`                                                                                                                               string                              
>   `>hashId`                                                                                                                             string                              
>   `stats`                                                                                                                               hash                                
>   `>trafficOpsPath`                                                                                                                     string                              
>   `>cdnName`                                                                                                                            string                              
>   `>trafficOpsVersion`                                                                                                                  string                              
>   `>trafficOpsUser`                                                                                                                     string                              
>   `>date`                                                                                                                               int                                 
>   `>trafficOpsHost`                                                                                                                     string                              
>   `cacheGroups`                                                                                                                         array                               A collection of cache groups.
>   `>coordinates`                                                                                                                        hash                                
>   `>>longitude`                                                                                                                         number                              
>   `>>latitude`                                                                                                                          number                              
>   `>name`                                                                                                                               string                              
>   `config`                                                                                                                              hash                                
>   `>tld.soa.admin`                                                                                                                      string                              
>   `>tcoveragezone.polling.interval`                                                                                                     int                                 
>   `>geolocation.polling.interval`                                                                                                       int                                 
>   `>tld.soa.expire`                                                                                                                     int                                 
>   `>coveragezone.polling.url`                                                                                                           string                              
>   `>tld.soa.minimum`                                                                                                                    int                                 
>   `>geolocation.polling.url`                                                                                                            string                              
>   `>domain_name`                                                                                                                        string                              
>   `>tld.ttls.AAAA`                                                                                                                      int                                 
>   `>tld.soa.refresh`                                                                                                                    int                                 
>   `>tld.ttls.NS`                                                                                                                        int                                 
>   `>tld.ttls.SOA`                                                                                                                       int                                 
>   `>geolocation6.polling.interval`                                                                                                      int                                 
>   `>tld.ttls.A`                                                                                                                         int                                 
>   `>tld.soa.retry`                                                                                                                      int                                 
>   `>geolocation6.polling.url`                                                                                                           string                              
>   `trafficMonitors`                                                                                                                     array                               A collection of Traffic Monitors.
>   `>profile`                                                                                                                            string                              
>   `>location`                                                                                                                           string                              
>   `>ip`                                                                                                                                 string                              
>   `>status`                                                                                                                             string                              
>   `>ip6`                                                                                                                                string                              
>   `>port`                                                                                                                               int                                 
>   `>hostName`                                                                                                                           string                              
>   `>fqdn`                                                                                                                               string                              
>   `deliveryServices`                                                                                                                    array                               A collection of delivery services.
>   `>xmlId`                                                                                                                              string                              
>   `>ttl`                                                                                                                                int                                 
>   `>geoEnabled`                                                                                                                         string                              
>   `>coverageZoneOnly`                                                                                                                   boolean                             
>   `>matchSets`                                                                                                                          array                               
>   `>>protocol`                                                                                                                          string                              
>   `>>matchList`                                                                                                                         array                               
>   `>>>regex`                                                                                                                            string                              
>   `>>>matchType`                                                                                                                        string                              
>   `>bypassDestination`                                                                                                                  hash                                
>   `>>maxDnsIpsForLocation`                                                                                                              int                                 
>   `>>ttl`                                                                                                                               int                                 
>   `>>type`                                                                                                                              string                              
>   `>ttls`                                                                                                                               hash                                
>   `>>A`                                                                                                                                 int                                 
>   `>>SOA`                                                                                                                               int                                 
>   `>>NS`                                                                                                                                int                                 
>   `>>AAAA`                                                                                                                              int                                 
>   `>missCoordinates`                                                                                                                    hash                                
>   `>>longitude`                                                                                                                         number                              
>   `>>latitude`                                                                                                                          number                              
>   `>soa`                                                                                                                                hash                                
>   `>>admin`                                                                                                                             string                              
>   `>>retry`                                                                                                                             int                                 
>   `>>minimum`                                                                                                                           int                                 
>   `>>refresh`                                                                                                                           int                                 
>   `>>expire`                                                                                                                            int                                 
>   `trafficRouters`                                                                                                                      hash                                
>   `>profile`                                                                                                                            int                                 
>   `>location`                                                                                                                           string                              
>   `>ip`                                                                                                                                 string                              
>   `>status`                                                                                                                             string                              
>   `>ip6`                                                                                                                                string                              
>   `>port`                                                                                                                               int                                 
>   `>hostName`                                                                                                                           string                              
>   `>fqdn`                                                                                                                               string                              
>   `>apiPort`                                                                                                                            int                                 
>
**Response Example**

::

:   TBD

DNSSEC Keys
-----------

**GET /api/1.1/cdns/name/:name/dnsseckeys**

> Gets a list of dnsseckeys for CDN and all associated Delivery
> Services. Before returning response to user, check to make sure keys
> aren't expired. If they are expired, generate new ones. Before
> returning response to user, make sure dnssec keys for all delivery
> services exist. If they don't exist, create them.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Route Parameters**
>
>   Name          Required      Description
>   ------------- ------------- ----------------
>   `name`        yes           
>
> **Response Properties**
>
>   Parameter                                                     Type                   Description
>   ------------------------------------------------------------- ---------------------- ---------------------------------------------------------------------------------------------------------------------------------------------
>   `cdn name/ds xml_id`                                          string                 identifier for ds or cdn
>   `>zsk/ksk`                                                    array                  collection of zsk/ksk data
>   `>>ttl`                                                       string                 time-to-live for dnssec requests
>   `>>inceptionDate`                                             string                 epoch timestamp for when the keys were created
>   `>>expirationDate`                                            string                 epoch timestamp representing the expiration of the keys
>   `>>private`                                                   string                 encoded private key
>   `>>public`                                                    string                 encoded public key
>   `>>name`                                                      string                 domain name
>   `version`                                                     string                 API version
>
> **Response Example** :
>
>     {
>       "response": {
>         "cdn1": {
>           "zsk": {
>             "ttl": "60",
>             "inceptionDate": "1426196750",
>             "private": "zsk private key",
>             "public": "zsk public key",
>             "expirationDate": "1428788750",
>             "name": "foo.kabletown.com."
>           },
>           "ksk": {
>             "name": "foo.kabletown.com.",
>             "expirationDate": "1457732750",
>             "public": "ksk public key",
>             "private": "ksk private key",
>             "inceptionDate": "1426196750",
>             "ttl": "60"
>           }
>         },
>         "ds-01": {
>           "zsk": {
>             "ttl": "60",
>             "inceptionDate": "1426196750",
>             "private": "zsk private key",
>             "public": "zsk public key",
>             "expirationDate": "1428788750",
>             "name": "ds-01.foo.kabletown.com."
>           },
>           "ksk": {
>             "name": "ds-01.foo.kabletown.com.",
>             "expirationDate": "1457732750",
>             "public": "ksk public key",
>             "private": "ksk private key",
>             "inceptionDate": "1426196750"
>           }
>         },
>         ... repeated for each ds in the cdn
>       },
>     }

| 

**GET /api/1.1/cdns/name/:name/dnsseckeys/delete**

> Delete dnssec keys for a cdn and all associated delivery services.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Route Parameters**
>
>   Name          Required      Description
>   ------------- ------------- ---------------------------------------------------------------------
>   `name`        yes           name of the CDN for which you want to delete dnssec keys
>
> **Response Properties**
>
>   Parameter             Type          Description
>   --------------------- ------------- ---------------------------
>   `response`            string        success response
>
> **Response Example** :
>
>     {  
>       "response": "Successfully deleted dnssec keys for <cdn>"
>     }

| 

**POST /api/1.1/deliveryservices/dnsseckeys/generate**

> Generates zsk and ksk keypairs for a cdn and all associated delivery
> services.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Properties**
>
>   Parameter                                          Type                  Description
>   -------------------------------------------------- --------------------- ------------------------------------------------------------------------------------------------------
>   `key`                                              string                name of the cdn
>   `name`                                             string                domain name of the cdn
>   `ttl`                                              string                time to live
>   `kskExpirationDays`                                string                Expiration (in days) for the key signing keys
>   `zskExpirationDays`                                string                Expiration (in days) for the zone signing keys
>
> **Request Example** :
>
>     {
>       "key": "cdn1",
>       "name" "ott.kabletown.com",
>       "ttl": "60",
>       "kskExpirationDays": "365",
>       "zskExpirationDays": "90"
>     }
>
> **Response Properties**
>
>   Parameter             Type          Description
>   --------------------- ------------- --------------------------
>   `response`            string        response string
>   `version`             string        API version
>
> **Response Example** :
>
>     {  
>       "response": "Successfully created dnssec keys for cdn1"
>     }