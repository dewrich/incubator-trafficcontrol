Status
======

/api/1.2/statuses
-----------------

**GET /api/1.2/statuses**

> Retrieves a list of the server status codes available.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                      Type            Description
>   ------------------------------ --------------- ---------------------------------------------------------------------------------------------------------------------------------------
>   `id`                           string          The id with which Traffic Ops stores this status, and references it internally
>   `name`                         string          The string equivalent of the status
>   `description`                  string          A short description of the status
>   `lastUpdated`                  string          The Time / Date this server entry was last updated
>
> **Response Example** :
>
>     {
>      "response": [
>        {
>          "id": "4",
>          "name": "ADMIN_DOWN",
>          "description": "Temporary down. Edge: XMPP client will send status OFFLINE to CCR, otherwise similar to REPORTED. Mid: Server will not be included in parent.config files for its edge caches",
>          "lastUpdated": "2013-02-13 16:34:29"
>        },
>        {
>          "id": "5",
>          "name": "CCR_IGNORE",
>          "description": "Edge: 12M will not include caches in this state in CCR config files. Mid: N\/A for now",
>          "lastUpdated": "2013-02-13 16:34:29"
>        },
>        {
>          "id": "1",
>          "name": "OFFLINE",
>          "description": "Edge: Puts server in CCR config file in this state, but CCR will never route traffic to it. Mid: Server will not be included in parent.config files for its edge caches",
>          "lastUpdated": "2013-02-13 16:34:29"
>        },
>        {
>          "id": "2",
>          "name": "ONLINE",
>          "description": "Edge: Puts server in CCR config file in this state, and CCR will always route traffic to it. Mid: Server will be included in parent.config files for its edges",
>          "lastUpdated": "2013-02-13 16:34:29"
>        },
>        {
>          "id": "3",
>          "name": "REPORTED",
>          "description": "Edge: Puts server in CCR config file in this state, and CCR will adhere to the health protocol. Mid: N\/A for now",
>          "lastUpdated": "2013-02-13 16:34:29"
>        }
>      ]
>
> > }

**GET /api/1.2/statuses/:id**

> Retrieves a server status by ID.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +-----------+----------+---------------------------------------------+
> | Name      | Required | Description                                 |
> +===========+==========+=============================================+
> | > `id`    | > yes    | Status id.                                  |
> +-----------+----------+---------------------------------------------+
>
> **Response Properties**
>
>   Parameter                      Type            Description
>   ------------------------------ --------------- ---------------------------------------------------------------------------------------------------------------------------------------
>   `id`                           string          The id with which Traffic Ops stores this status, and references it internally
>   `name`                         string          The string equivalent of the status
>   `description`                  string          A short description of the status
>   `lastUpdated`                  string          The Time / Date this server entry was last updated
>
> **Response Example** :
>
>     {
>      "response": [
>        {
>          "id": "4",
>          "name": "ADMIN_DOWN",
>          "description": "Temporary down. Edge: XMPP client will send status OFFLINE to CCR, otherwise similar to REPORTED. Mid: Server will not be included in parent.config files for its edge caches",
>          "lastUpdated": "2013-02-13 16:34:29"
>        }
>      ]
>
> > }
