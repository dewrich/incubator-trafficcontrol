Federation
==========

/api/1.2/federations
--------------------

**GET /api/1.2/federations.json**

> Retrieves a list of federation mappings (aka federation resolvers) for
> a the current user.
>
> Authentication Required: Yes
>
> Role(s) Required: Federation
>
> **Response Properties**
>
> +-----------------+------+--------------------------------------------+
> | Parameter       | Type | Description                                |
> +=================+======+============================================+
> | `cname`         | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `ttl`           | > in | Time to live for the cname.                |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `deliveryServic | stri | Unique string that describes the           |
> | e`              | ng   | deliveryservice.                           |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>           "mappings": [
>             "cname": "cname-01.",
>             "ttl": 8865,
>           ]
>           "deliveryService": "ds-01",
>         }
>       ]
>     }

| 

**POST /api/1.2/federations.json**

> Allows a user to add federations for their delivery service(s).
>
> Authentication Required: Yes
>
> Role(s) Required: Federation
>
> **Request Properties**
>
>   Parameter                                      Type                Description
>   ---------------------------------------------- ------------------- ---------------------------------------------------------------------------------------------------------------
>   `deliveryService`                              string              Unique string that describes the deliveryservice.
>   `resolve4`                                     array               Array of IPv4 Addresses.
>   `resolve6`                                     array               Array of IPv6 Addresses.
>
> **Request Example** :
>
>     {
>       "federations": [
>         {
>           "deliveryService": "ccp-omg-01",
>           "mappings": {
>             "resolve4": [
>               "255.255.255.255"
>             ],
>             "resolve6": [
>               "FE80::0202:B3FF:FE1E:8329",
>             ]
>           }
>         }
>       ]
>     }

| 

**DELETE /api/1.2/federations.json**

> Deletes **all** federations associated with a user's delivery
> service(s).
>
> Authentication Required: Yes
>
> Role(s) Required: Federation

| 

**PUT /api/1.2/federations.json**

> Deletes **all** federations associated with a user's delivery
> service(s) then adds the new federations.
>
> Authentication Required: Yes
>
> Role(s) Required: Federation
>
> **Request Properties**
>
>   Parameter                                      Type                Description
>   ---------------------------------------------- ------------------- ---------------------------------------------------------------------------------------------------------------
>   `deliveryService`                              string              Unique string that describes the deliveryservice.
>   `resolve4`                                     array               Array of IPv4 Addresses.
>   `resolve6`                                     array               Array of IPv6 Addresses.
>
> **Request Example** :
>
>     {
>       "federations": [
>         {
>           "deliveryService": "ccp-omg-01",
>           "mappings": {
>             "resolve4": [
>               "255.255.255.255"
>             ],
>             "resolve6": [
>               "FE80::0202:B3FF:FE1E:8329",
>             ]
>           }
>         }
>       ]
>     }

| 

**GET /api/1.2/cdns/:name/federations**

> Retrieves a list of federations for a cdn.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
> +-----------------+------+--------------------------------------------+
> | Parameter       | Type | Description                                |
> +=================+======+============================================+
> | `cname`         | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `ttl`           | > in | Time to live for the cname.                |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `deliveryServic | > ha |                                            |
> | e`              | sh   |                                            |
> +-----------------+------+--------------------------------------------+
> | `>>id`          | > in | Delivery service ID                        |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `>>xmlId`       | stri | Delivery service xml id                    |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": 41
>             "cname": "booya.com.",
>             "ttl": 34,
>             "description": "fooya",
>             "deliveryService": {
>                 "id": 61,
>                 "xmlId": "the-xml-id"
>             }
>         }
>       ]
>     }

| 

**GET /api/1.2/cdns/:name/federations/:id**

> Retrieves a federation for a cdn.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                      Type           Description
>   ------------------------- -------------- --------------------------------------------------------------
>   `cdn`                     string         CDN name.
>   `federation`              string         Federation ID.
>
> **Response Properties**
>
> +-----------------+------+--------------------------------------------+
> | Parameter       | Type | Description                                |
> +=================+======+============================================+
> | `cname`         | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `ttl`           | > in | Time to live for the cname.                |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `deliveryServic | > ha |                                            |
> | e`              | sh   |                                            |
> +-----------------+------+--------------------------------------------+
> | `>>id`          | > in | Delivery service ID                        |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `>>xmlId`       | stri | Delivery service xml id                    |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": 41
>             "cname": "booya.com.",
>             "ttl": 34,
>             "description": "fooya",
>             "deliveryService": {
>                 "id": 61,
>                 "xmlId": "the-xml-id"
>             }
>         }
>       ]
>     }

| 

**POST /api/1.2/cdns/:name/federations**

:   Create a federation

    Authentication Required: Yes

    Role(s) Required: Admin

    **Request Route Parameters**

      Name                    Type          Description
      ----------------------- ------------- ---------------------------------------------------------
      `cdn`                   string        CDN name.

    **Request Properties**

      Parameter                       Required        Description
      ------------------------------- --------------- ------------------------------------
      `cname`                         yes             CNAME ending with a dot
      `ttl`                           yes             TTL
      `description`                   no              Description

    **Request Example** :

        {
            "cname": "the.cname.com.",
            "ttl": 48,
            "description": "the description"
        }

| 

> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `cname`                                string          
>   `ttl`                                  string          
>   `description`                          string          
>
> **Response Example** :
>
>     {
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Federation created [ cname = the.cname. ] with id: 26."
>             }
>         ],
>         "response": {
>             "id": 26,
>             "cname": "the.cname.com.",
>             "ttl": 48,
>             "description": "the description",
>         }
>     }

| 

**PUT /api/1.2/cdns/:name/federations/:id**

:   Update a federation

    Authentication Required: Yes

    Role(s) Required: Admin

    **Request Route Parameters**

      Name                      Type           Description
      ------------------------- -------------- --------------------------------------------------------------
      `cdn`                     string         CDN name.
      `federation`              string         Federation ID.

    **Request Properties**

      Parameter                       Required        Description
      ------------------------------- --------------- ------------------------------------
      `cname`                         yes             CNAME ending with a dot
      `ttl`                           yes             TTL
      `description`                   no              Description

    **Request Example** :

        {
            "cname": "the.cname.com.",
            "ttl": 48,
            "description": "the description"
        }

| 

> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `cname`                                string          
>   `ttl`                                  string          
>   `description`                          string          
>
> **Response Example** :
>
>     {
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Federation updated [ cname = the.cname. ] with id: 26."
>             }
>         ],
>         "response": {
>             "id": 26,
>             "cname": "the.cname.com.",
>             "ttl": 48,
>             "description": "the description",
>         }
>     }

| 

**DELETE /api/1.2/cdns/:name/federations/{:id}**

> Allow user to delete a federation.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Route Parameters**
>
>   Name                      Type           Description
>   ------------------------- -------------- --------------------------------------------------------------
>   `cdn`                     string         CDN name.
>   `federation`              string         Federation ID.
>
> **Response Properties**
>
>   Parameter            Type          Description
>   -------------------- ------------- --------------------------------------------------
>   `alerts`             array         A collection of alert messages.
>   `>level`             string        Success, info, warning or error.
>   `>text`              string        Alert message.
>   `version`            string        
>
> **Response Example** :
>
>     {
>           "alerts": [
>                     {
>                             "level": "success",
>                             "text": "Federation deleted [ cname = the.cname. ] with id: 26."
>                     }
>             ],
>     }

| 
