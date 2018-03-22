Capabilities
============

/api/1.2/capabilities
---------------------

**GET /api/1.2/capabilities**

> Get all capabilities.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                         Type            Description
>   --------------------------------- --------------- -----------------------------------------------------------------------------------
>   `name`                            string          Capability name.
>   `description`                     string          Describing the APIs covered by the capability.
>   `lastUpdated`                     string          
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "name": "cdn-read",
>               "description": "View CDN configuration",
>               "lastUpdated": "2017-04-02 08:22:43"
>            },
>            {
>               "name": "cdn-write",
>               "description": "Create, edit or delete CDN configuration",
>               "lastUpdated": "2017-04-02 08:22:43"
>            }
>         ]
>     }

| 

**GET /api/1.2/capabilities/:name**

> Get a capability by name.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-------------+----------+--------+------------------------------------+
> | Name        | Required | Type   | Description                        |
> +=============+==========+========+====================================+
> | > `name`    | > yes    | string | Capability name.                   |
> +-------------+----------+--------+------------------------------------+
>
> **Response Properties**
>
>   Parameter                         Type            Description
>   --------------------------------- --------------- -----------------------------------------------------------------------------------
>   `name`                            string          Capability name.
>   `description`                     string          Describing the APIs covered by the capability.
>   `lastUpdated`                     string          
>
> **Response Example** :
>
>     {
>      "response": [
>            {
>               "name": "cdn-read",
>               "description": "View CDN configuration",
>               "lastUpdated": "2017-04-02 08:22:43"
>            }
>         ]
>     }

| 

**POST /api/1.2/capabilities**

> Create a capability.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Parameters**
>
> +-------------+--------+------+---------------------------------------+
> | Name        | Requir | Type | Description                           |
> |             | ed     |      |                                       |
> +=============+========+======+=======================================+
> | > `name`    | yes    | stri | Capability name.                      |
> |             |        | ng   |                                       |
> +-------------+--------+------+---------------------------------------+
> | `descriptio | yes    | stri | Describing the APIs covered by the    |
> | n`          |        | ng   | capability.                           |
> +-------------+--------+------+---------------------------------------+
>
> **Request Example** :
>
>     {
>         "name": "cdn-write",
>         "description": "Create, edit or delete CDN configuration"
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
> | `>name`         | strin | Capability name.                           |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>description`  | strin | Describing the APIs covered by the         |
> |                 | g     | capability.                                |
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
>             "name": "cdn-write",
>             "description": "Create, edit or delete CDN configuration"
>         },
>         "alerts":[
>             {
>                 "level": "success",
>                 "text": "Capability was created."
>             }
>         ]
>     }

| 

**PUT /api/1.2/capabilities/{:name}**

> Edit a capability.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
>   Name                    Type          Description
>   ----------------------- ------------- ---------------------------------------------------------
>   `name`                  int           Capability name.
>
> **Request Properties**
>
>   Parameter                         Type            Description
>   --------------------------------- --------------- -----------------------------------------------------------------------------------
>   `description`                     string          Describing the APIs covered by the capability.
>
> **Request Example** :
>
>     {
>         "description": "View CDN configuration"
>     }
>
> **Response Properties**
>
> +-----------------+-------+--------------------------------------------+
> | Parameter       | Type  | Description                                |
> +=================+=======+============================================+
> | `response`      | > has | The details of the update, if success.     |
> |                 | h     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>name`         | strin | Capability name.                           |
> |                 | g     |                                            |
> +-----------------+-------+--------------------------------------------+
> | `>description`  | > int | Describing the APIs covered by the         |
> |                 |       | capability.                                |
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
>             "name": "cdn-read",
>             "description": "View CDN configuration"
>         },
>         "alerts":[
>             {
>                 "level": "success",
>                 "text": "Capability was updated."
>             }
>         ]
>     }

| 

**DELETE /api/1.2/capabilities/{:name}**

> Delete a capability.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- ---------------------------------------------------------
>   `name`                yes           Capability name.
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
>                             "text": "Capability deleted."
>                     }
>             ],
>     }
