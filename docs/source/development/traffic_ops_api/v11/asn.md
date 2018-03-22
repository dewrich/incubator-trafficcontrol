ASN
===

/api/1.1/asns
-------------

**GET /api/1.1/asns**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                         Type             Description
>   --------------------------------- ---------------- -----------------------------------------------------------------------------------------------------------------------------------
>   `asns`                            array            A collection of asns
>   `>lastUpdated`                    string           The Time / Date this server entry was last updated
>   `>id`                             string           Local unique identifier for the ASN
>   `>asn`                            string           Autonomous System Numbers per APNIC for identifying a service provider.
>   `>cachegroup`                     string           Related cachegroup name
>
> **Response Example** :
>
>     {
>      "response": {
>         "asns": [
>            {
>               "lastUpdated": "2012-09-17 21:41:22",
>               "id": "27",
>               "asn": "7015",
>               "cachegroup": "us-ma-woburn"
>            },
>            {
>               "lastUpdated": "2012-09-17 21:41:22",
>               "id": "28",
>               "asn": "7016",
>               "cachegroup": "us-pa-pittsburgh"
>            }
>         ]
>      },
>     }
