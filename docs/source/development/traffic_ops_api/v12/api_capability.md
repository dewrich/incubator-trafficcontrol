API-Capabilities
================

/api/1.2/api\_capabilities
--------------------------

**GET /api/1.2/api\_capabilities**

> Get all API-capability mappings.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Query Parameters**
>
> +---------------+---------+-------+-----------------------------------+
> | Name          | Require | Type  | Description                       |
> |               | d       |       |                                   |
> +===============+=========+=======+===================================+
> | `capability`  | > no    | strin | Capability name.                  |
> |               |         | g     |                                   |
> +---------------+---------+-------+-----------------------------------+
>
> **Response Properties**
>
>   Parameter                         Type            Description
>   --------------------------------- --------------- -------------------------------------------------------------------------------------
>   `id`                              int             Mapping id.
>   `httpMethod`                      enum            One of: 'GET', 'POST', 'PUT', 'PATCH', 'DELETE'.
>   `route`                           string          API route.
>   `capability`                      string          Capability name.
>   `lastUpdated`                     string          
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "id": "6",
>               "httpMethod": "GET",
>               "route": "/api/*/asns",
>               "capability": "asn-read",
>               "lastUpdated": "2017-04-02 08:22:43"
>            },
>            {
>               "id": "7",
>               "httpMethod": "GET",
>               "route": "/api/*/asns/*",
>               "capability": "asn-read",
>               "lastUpdated": "2017-04-02 08:22:43"
>            }
>         ]
>     }

| 

**GET /api/1.2/api\_capabilities/:id**

> Get an API-capability mapping by id.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-------------+----------+-------+-------------------------------------+
> | Name        | Required | Type  | Description                         |
> +=============+==========+=======+=====================================+
> | > `id`      | > yes    | int   | Mapping id.                         |
> +-------------+----------+-------+-------------------------------------+
>
> **Response Properties**
>
>   Parameter                         Type            Description
>   --------------------------------- --------------- -------------------------------------------------------------------------------------
>   `id`                              int             Mapping id.
>   `httpMethod`                      enum            One of: 'GET', 'POST', 'PUT', 'PATCH', 'DELETE'.
>   `route`                           string          API route.
>   `capability`                      string          Capability name.
>   `lastUpdated`                     string          
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "id": "6",
>               "httpMethod": "GET",
>               "route": "/api/*/asns",
>               "capability": "asn-read",
>               "lastUpdated": "2017-04-02 08:22:43"
>            }
>         ]
>     }

| 

**POST /api/1.2/api\_capabilities**

> Create an API-capability mapping.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Properties**
>
>   Name                       Required          Type           Description
>   -------------------------- ----------------- -------------- -------------------------------------------------------------------------------
>   `httpMethod`               yes               enum           One of: 'GET', 'POST', 'PUT', 'PATCH', 'DELETE'.
>   `route`                    yes               string         API route.
>   `capability`               yes               string         Capability name
>
> **Request Example** :
>
>     {
>         "httpMethod": "POST",
>         "route": "/api/*/cdns",
>         "capability": "cdn-write"
>     }
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `response`      | > has | The details of the creation, if success.   |
> |                 | h     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>id`           | int   | Mapping id.                                |
> +-----------------+-------+--------------------------------------------+
> | `>httpMethod`   | enum  | One of: 'GET', 'POST', 'PUT', 'PATCH',     |
> |                 |       | 'DELETE'.                                  |
> +-----------------+-------+--------------------------------------------+
> | `>route`        | strin | API route.                                 |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>capability`   | strin | Capability name                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>lastUpdated`  | strin |                                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `alerts`        | array | A collection of alert messages.            |
> +-----------------+-------+--------------------------------------------+
> | `>level`        | strin | Success, info, warning or error.           |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>text`         | strin | Alert message.                             |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>         "response":{
>               "id": "6",
>               "httpMethod": "POST",
>               "route": "/api/*/cdns",
>               "capability": "cdn-write",
>               "lastUpdated": "2017-04-02 08:22:43"
>         },
>         "alerts":[
>             {
>                 "level": "success",
>                 "text": "API-capability mapping was created."
>             }
>         ]
>     }

| 

**PUT /api/1.2/api\_capabilities/{:id}**

> Edit an API-capability mapping.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
> +-----------------+--------+-------+-----------------------------------+
> | Name            | Requir | Type  | Description                       |
> |                 | ed     |       |                                   |
> +=================+========+=======+===================================+
> | > `id`          | > yes  | strin | Mapping id.                       |
> |                 |        | g     |                                   |
> +-----------------+--------+-------+-----------------------------------+
>
> **Request Properties**
>
>   Parameter                       Type           Description
>   ------------------------------- -------------- -------------------------------------------------------------------------------
>   `httpMethod`                    enum           One of: 'GET', 'POST', 'PUT', 'PATCH', 'DELETE'.
>   `route`                         string         API route.
>   `capability`                    string         Capability name
>
> **Request Example** :
>
>     {
>         "httpMethod": "GET",
>         "route": "/api/*/cdns",
>         "capability": "cdn-read"
>     }
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `response`      | > has | The details of the creation, if success.   |
> |                 | h     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>id`           | int   | Mapping id.                                |
> +-----------------+-------+--------------------------------------------+
> | `>httpMethod`   | enum  | One of: 'GET', 'POST', 'PUT', 'PATCH',     |
> |                 |       | 'DELETE'.                                  |
> +-----------------+-------+--------------------------------------------+
> | `>route`        | strin | API route.                                 |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>capability`   | strin | Capability name                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>lastUpdated`  | strin |                                            |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `alerts`        | array | A collection of alert messages.            |
> +-----------------+-------+--------------------------------------------+
> | `>level`        | strin | Success, info, warning or error.           |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>text`         | strin | Alert message.                             |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>         "response":{
>               "id": "6",
>               "httpMethod": "GET",
>               "route": "/api/*/cdns",
>               "capability": "cdn-read",
>               "lastUpdated": "2017-04-02 08:22:43"
>         },
>         "alerts":[
>             {
>                 "level": "success",
>                 "text": "API-capability mapping was updated."
>             }
>         ]
>     }

| 

**DELETE /api/1.2/api\_capabilities/{:id}**

> Delete a capability.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
> +-----------------+--------+-------+-----------------------------------+
> | Name            | Requir | Type  | Description                       |
> |                 | ed     |       |                                   |
> +=================+========+=======+===================================+
> | > `id`          | > yes  | strin | Mapping id.                       |
> |                 |        | g     |                                   |
> +-----------------+--------+-------+-----------------------------------+
>
> **Response Properties**
>
> +---------------+---------+--------------------------------------------+
> | Parameter     | Type    | Description                                |
> +===============+=========+============================================+
> | > `alerts`    | > array | > A collection of alert messages.          |
> +---------------+---------+--------------------------------------------+
> | > `>level`    | > strin | > success, info, warning or error.         |
> |               | g       |                                            |
> +---------------+---------+--------------------------------------------+
> | > `>text`     | > strin | > Alert message.                           |
> |               | g       |                                            |
> +---------------+---------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>           "alerts": [
>                     {
>                             "level": "success",
>                             "text": "API-capability mapping deleted."
>                     }
>             ],
>     }
