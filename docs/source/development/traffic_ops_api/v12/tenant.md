Tenants
=======

/api/1.2/tenants
----------------

**GET /api/1.2/tenants**

> Get all tenants.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Tenant id                                |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `name`            | stri | Tenant name                              |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `active`          | > bo | Active or inactive                       |
> |                   | ol   |                                          |
> +-------------------+------+------------------------------------------+
> | `parentId`        | > in | Parent tenant ID                         |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `parentName`      | stri | Parent tenant name                       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": 1
>            "name": "root",
>            "active": true,
>            "parentId": null,
>            "parentName": null,
>         },
>         {
>            "id": 2
>            "name": "tenant-a",
>            "active": true,
>            "parentId": 1
>            "parentName": "root"
>         }
>      ]
>     }

| 

**GET /api/1.2/tenants/:id**

> Get a tenant by ID.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Tenant id                                |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `name`            | stri | Tenant name                              |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `active`          | > bo | Active or inactive                       |
> |                   | ol   |                                          |
> +-------------------+------+------------------------------------------+
> | `parentId`        | > in | Parent tenant ID                         |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `parentName`      | stri | Parent tenant name                       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": 2
>            "name": "tenant-a",
>            "active": true,
>            "parentId": 1,
>            "parentName": "root"
>         }
>      ]
>     }

| 

**PUT /api/1.2/tenants/:id**

> Update a tenant.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
> +-----------------+--------+-------------------------------------------+
> | Name            | Type   | Description                               |
> +=================+========+===========================================+
> | `id`            | > int  | Tenant id                                 |
> +-----------------+--------+-------------------------------------------+
>
> **Request Properties**
>
>   Parameter               Required      Description
>   ----------------------- ------------- -------------------------------
>   `name`                  yes           The name of the tenant
>   `active`                yes           True or false
>   `parentId`              yes           Parent tenant
>
> **Request Example** :
>
>     {
>         "name": "my-tenant"
>         "active": true
>         "parentId": 1
>     }

| 

> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Tenant id                                |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `name`            | stri | Tenant name                              |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `active`          | > bo | Active or inactive                       |
> |                   | ol   |                                          |
> +-------------------+------+------------------------------------------+
> | `parentId`        | > in | Parent tenant ID                         |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `parentName`      | stri | Parent tenant name                       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>         "response": {
>             "id": 2,
>             "name": "my-tenant",
>             "active": true,
>             "parentId": 1,
>             "parentName": "root",
>             "lastUpdated": "2014-03-18 08:57:39"
>         },
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Tenant update was successful."
>             }
>         ]
>     }

| 

**POST /api/1.2/tenants**

> Create a tenant.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Properties**
>
>   Parameter               Required      Description
>   ----------------------- ------------- -------------------------------
>   `name`                  yes           The name of the tenant
>   `active`                no            Defaults to false
>   `parentId`              yes           Parent tenant
>
> **Request Example** :
>
>     {
>         "name": "your-tenant"
>         "parentId": 2
>     }

| 

> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Tenant id                                |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `name`            | stri | Tenant name                              |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `active`          | > bo | Active or inactive                       |
> |                   | ol   |                                          |
> +-------------------+------+------------------------------------------+
> | `parentId`        | > in | Parent tenant ID                         |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `parentName`      | stri | Parent tenant name                       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>         "response": {
>             "id": 2,
>             "name": "your-tenant",
>             "active": false,
>             "parentId": 2,
>             "parentName": "my-tenant",
>             "lastUpdated": "2014-03-18 08:57:39"
>         },
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Tenant create was successful."
>             }
>         ]
>     }

| 
