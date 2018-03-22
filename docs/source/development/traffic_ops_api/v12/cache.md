Cache
=====

/api/1.2/caches/stats
---------------------

**GET /api/1.2/caches/stats**

> Retrieves cache stats from Traffic Monitor. Also includes rows for
> aggregates.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                   Type            Description
>   --------------------------- --------------- ------------------------------------------------------------------------------------
>   `profile`                   string          The profile of the cache.
>   `cachegroup`                string          The cache group of the cache.
>   `hostname`                  string          The hostname of the cache.
>   `ip`                        string          The IP address of the cache.
>   `status`                    string          The status of the cache.
>   `healthy`                   string          Has Traffic Monitor marked the cache as healthy or unhealthy?
>   `connections`               string          Cache connections
>   `kbps`                      string          Cache kbps out
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>           "profile": "ALL",
>           "cachegroup": "ALL",
>           "hostname": "ALL",
>           "ip": null,
>           "status": "ALL",
>           "healthy": true,
>           "connections": 934424,
>           "kbps": 618631875
>         },
>         {
>           "profile": "EDGE1_FOO_721-ATS621-45",
>           "cachegroup": "us-nm-albuquerque",
>           "hostname": "foo-bar-alb-01",
>           "ip": "2.2.2.2",
>           "status": "REPORTED",
>           "healthy": true,
>           "connections": 373,
>           "kbps": 390136
>         },
>       ]
>     }

| 
