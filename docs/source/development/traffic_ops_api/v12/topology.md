Snapshot CRConfig
=================

/api/1.2/snapshot/{:cdn\_name}
------------------------------

**GET /api/1.2/cdns/{:cdn\_name}/snapshot**

> Retrieves the CURRENT snapshot for a CDN which doesn't necessarily
> represent the current state of the CDN. The contents of this snapshot
> are currently used by Traffic Monitor and Traffic Router.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin or Operations
>
> **Request Route Parameters**
>
> +---------------+---------+-------------------------------------------+
> | Name          | Require | Description                               |
> |               | d       |                                           |
> +===============+=========+===========================================+
> | > `cdn_name`  | > yes   | CDN name.                                 |
> +---------------+---------+-------------------------------------------+
>
> **Response Properties**
>
> +--------------+----+-------------------------------------------------+
> | Parameter    | Ty | Description                                     |
> |              | pe |                                                 |
> +==============+====+=================================================+
> | `config`     | >  | General CDN configuration settings.             |
> |              | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `contentRout | >  | A list of Traffic Routers.                      |
> | ers`         | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `contentServ | >  | A list of Traffic Servers and the delivery      |
> | ers`         | ha | services associated with each.                  |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `deliverySer | >  | A list of delivery services.                    |
> | vices`       | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `edgeLocatio | >  | A list of cache groups.                         |
> | ns`          | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `stats`      | >  | Snapshot properties.                            |
> |              | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": {
>             "config": { ... },
>             "contentRouters": { ... },
>             "contentServers": { ... },
>             "deliveryServices": { ... },
>             "edgeLocations": { ... },
>             "stats": { ... },
>         },
>     }

| 

**GET /api/1.2/cdns/{:cdn\_name}/snapshot/new**

> Retrieves a PENDING snapshot for a CDN which represents the current
> state of the CDN. The contents of this snapshot are NOT currently used
> by Traffic Monitor and Traffic Router. Once a snapshot is performed,
> this snapshot will become the CURRENT snapshot and will be used by
> Traffic Monitor and Traffic Router.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin or Operations
>
> **Request Route Parameters**
>
> +---------------+---------+-------------------------------------------+
> | Name          | Require | Description                               |
> |               | d       |                                           |
> +===============+=========+===========================================+
> | > `cdn_name`  | > yes   | CDN name.                                 |
> +---------------+---------+-------------------------------------------+
>
> **Response Properties**
>
> +--------------+----+-------------------------------------------------+
> | Parameter    | Ty | Description                                     |
> |              | pe |                                                 |
> +==============+====+=================================================+
> | `config`     | >  | General CDN configuration settings.             |
> |              | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `contentRout | >  | A list of Traffic Routers.                      |
> | ers`         | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `contentServ | >  | A list of Traffic Servers and the delivery      |
> | ers`         | ha | services associated with each.                  |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `deliverySer | >  | A list of delivery services.                    |
> | vices`       | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `edgeLocatio | >  | A list of cache groups.                         |
> | ns`          | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
> | `stats`      | >  | Snapshot properties.                            |
> |              | ha |                                                 |
> |              | sh |                                                 |
> +--------------+----+-------------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": {
>             "config": { ... },
>             "contentRouters": { ... },
>             "contentServers": { ... },
>             "deliveryServices": { ... },
>             "edgeLocations": { ... },
>             "stats": { ... },
>         },
>     }

| 

**PUT /api/1.2/snapshot/{:cdn\_name}**

> Authentication Required: Yes
>
> Role(s) Required: Admin or Operations
>
> **Request Route Parameters**
>
>   Name          Required      Description
>   ------------- ------------- ----------------------------------------------------
>   cdn\_name     yes           The name of the cdn to snapshot configure
>
> **Response Properties**
>
> +-------------------+-------+------------------------------------------+
> | Parameter         | Type  | Description                              |
> +===================+=======+==========================================+
> | response          | strin | > "SUCCESS"                              |
> |                   | g     |                                          |
> +-------------------+-------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": "SUCCESS"
>     }

| 
