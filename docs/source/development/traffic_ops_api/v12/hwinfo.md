Hardware Info
=============

/api/1.2/hwinfo
---------------

**GET /api/1.2/hwinfo.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                                  Type               Description
>   ------------------------------------------ ------------------ ----------------------------------------------------------------------------------------------------------------------------------------------
>   `serverId`                                 string             Local unique identifier for this specific server's hardware info
>   `serverHostName`                           string             Hostname for this specific server's hardware info
>   `lastUpdated`                              string             The Time and Date for the last update for this server.
>   `val`                                      string             Freeform value used to track anything about a server's hardware info
>   `description`                              string             Freeform description for this specific server's hardware info
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "serverId": "odol-atsmid-cen-09",
>            "lastUpdated": "2014-05-27 09:06:02",
>            "val": "D1S4",
>            "description": "Physical Disk 0:1:0"
>         },
>         {
>            "serverId": "odol-atsmid-cen-09",
>            "lastUpdated": "2014-05-27 09:06:02",
>            "val": "D1S4",
>            "description": "Physical Disk 0:1:1"
>         }
>      ]
>     }

| 
