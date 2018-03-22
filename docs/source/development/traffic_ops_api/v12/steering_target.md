Steering Targets
================

**GET /api/1.2/steering/:dsId/targets**

> Get all targets for a steering delivery service.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-------------+----------+---------------------------------------------+
> | Name        | Required | Description                                 |
> +=============+==========+=============================================+
> | `dsId`      | > yes    | DS ID.                                      |
> +-------------+----------+---------------------------------------------+
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `deliveryServiceI | > in | DS ID                                    |
> | d`                | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `deliveryService` | stri | DS XML ID                                |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `targetId`        | > in | Target DS ID                             |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `target`          | stri | Target DS XML ID                         |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `value`           | > in | Value is weight or order depending on    |
> |                   | t    | type                                     |
> +-------------------+------+------------------------------------------+
> | `typeId`          | > in | Steering target type ID                  |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `type`            | stri | Steering target type name                |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "deliveryServiceId": 1
>            "deliveryService": "steering-ds-one",
>            "targetId": 2,
>            "target": "steering-target-one",
>            "value": 1,
>            "typeId": 35,
>            "type": "STEERING_ORDER"
>         },
>         {
>            "deliveryServiceId": 1
>            "deliveryService": "steering-ds-one",
>            "targetId": 3,
>            "target": "steering-target-two",
>            "value": 2,
>            "typeId": 35,
>            "type": "STEERING_ORDER"
>         },
>      ]
>     }

| 

**GET /api/1.2/steering/:dsId/targets/:targetId**

> Get a steering target.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-------------+----------+---------------------------------------------+
> | Name        | Required | Description                                 |
> +=============+==========+=============================================+
> | `dsId`      | > yes    | DS ID.                                      |
> +-------------+----------+---------------------------------------------+
> | `targetId`  | > yes    | DS Target ID.                               |
> +-------------+----------+---------------------------------------------+
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `deliveryServiceI | > in | DS ID                                    |
> | d`                | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `deliveryService` | stri | DS XML ID                                |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `targetId`        | > in | Target DS ID                             |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `target`          | stri | Target DS XML ID                         |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `value`           | > in | Value is weight or order depending on    |
> |                   | t    | type                                     |
> +-------------------+------+------------------------------------------+
> | `typeId`          | > in | Steering target type ID                  |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `type`            | stri | Steering target type name                |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "deliveryServiceId": 1
>            "deliveryService": "steering-ds-one",
>            "targetId": 2,
>            "target": "steering-target-one",
>            "value": 1,
>            "typeId": 35,
>            "type": "STEERING_ORDER"
>         }
>      ]
>     }

| 

**PUT /api/1.2/steering/:dsId/targets/:targetId**

> Update a steering target.
>
> Authentication Required: Yes
>
> Role(s) Required: Portal
>
> **Request Route Parameters**
>
> +-------------+----------+---------------------------------------------+
> | Name        | Required | Description                                 |
> +=============+==========+=============================================+
> | `dsId`      | > yes    | DS ID.                                      |
> +-------------+----------+---------------------------------------------+
> | `targetId`  | > yes    | DS Target ID.                               |
> +-------------+----------+---------------------------------------------+
>
> **Request Properties**
>
>   Parameter                     Required      Description
>   ----------------------------- ------------- -------------------------------
>   `value`                       yes           Target value
>   `typeId`                      yes           Target type ID
>
> **Request Example** :
>
>     {
>         "value": 34,
>         "typeId": 46,
>     }

| 

> **Response Properties**
>
>   Parameter                                       Type                  Description
>   ----------------------------------------------- --------------------- ---------------------------------------------------
>   `deliveryServiceId`                             int                   Steering DS ID
>   `deliveryService`                               string                DS XML ID
>   `targetId`                                      int                   Target DS ID
>   `target`                                        string                Target DS XML ID
>   `value`                                         string                Target value
>   `typeId`                                        int                   Target type ID
>   `type`                                          string                Steering target type name
>
> **Response Example** :
>
>     {
>         "response": {
>             "deliveryServiceId": 1,
>             "deliveryService": "steering-ds-one",
>             "targetId": 2,
>             "target": "steering-target-two",
>             "value": "34",
>             "typeId": 45,
>             "type": "STEERING_ORDER"
>         },
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Delivery service steering target update was successful."
>             }
>         ]
>     }

| 

**POST /api/1.2/steering/:dsId/targets**

> Create a steering target.
>
> Authentication Required: Yes
>
> Role(s) Required: Portal
>
> **Request Route Parameters**
>
> +-------------+----------+---------------------------------------------+
> | Name        | Required | Description                                 |
> +=============+==========+=============================================+
> | `dsId`      | > yes    | DS ID.                                      |
> +-------------+----------+---------------------------------------------+
>
> **Request Properties**
>
>   Parameter                     Required      Description
>   ----------------------------- ------------- -------------------------------
>   `targetId`                    yes           Target DS ID
>   `value`                       yes           Target value
>   `typeId`                      yes           Target type ID
>
> **Request Example** :
>
>     {
>         "targetId": 6,
>         "value": 22,
>         "typeId": 47,
>     }

| 

> **Response Properties**
>
>   Parameter                                       Type                  Description
>   ----------------------------------------------- --------------------- ---------------------------------------------------
>   `deliveryServiceId`                             int                   Steering DS ID
>   `deliveryService`                               string                DS XML ID
>   `targetId`                                      int                   Target DS ID
>   `target`                                        string                Target DS XML ID
>   `value`                                         string                Target value
>   `typeId`                                        int                   Target type ID
>   `type`                                          string                Steering target type name
>
> **Response Example** :
>
>     {
>         "response": {
>             "deliveryServiceId": 1,
>             "deliveryService": "steering-ds-one",
>             "targetId": 6,
>             "target": "steering-target-six",
>             "value": "22",
>             "typeId": 47,
>             "type": "STEERING_ORDER"
>         },
>         "alerts": [
>             {
>                 "level": "success",
>                 "text": "Delivery service target creation was successful."
>             }
>         ]
>     }

| 

**DELETE /api/1.2/steering/:dsId/targets/:targetId**

> Delete a steering target.
>
> Authentication Required: Yes
>
> Role(s) Required: Portal
>
> **Request Route Parameters**
>
> +-------------+----------+---------------------------------------------+
> | Name        | Required | Description                                 |
> +=============+==========+=============================================+
> | `dsId`      | > yes    | DS ID.                                      |
> +-------------+----------+---------------------------------------------+
> | `targetId`  | > yes    | DS Target ID.                               |
> +-------------+----------+---------------------------------------------+
>
> **Response Example** :
>
>     {
>           "alerts": [
>                     {
>                             "level": "success",
>                             "text": "Delivery service target delete was successful."
>                     }
>             ],
>     }

| 
