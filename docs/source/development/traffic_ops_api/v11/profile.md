Profiles
========

/api/1.1/profiles
-----------------

**GET /api/1.1/profiles**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                      Type            Description
>   ------------------------------ --------------- ----------------------------------------------------------------------------------------
>   `lastUpdated`                  array           The Time / Date this server entry was last updated
>   `name`                         string          The name for the profile
>   `id`                           string          Primary key
>   `description`                  string          The description for the profile
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "lastUpdated": "2012-10-08 19:34:45",
>             "name": "CCR_TOP",
>             "id": "8",
>             "description": "Content Router for top.foobar.net"
>         }
>      ]
>     }

| 

**GET /api/1.1/profiles/trimmed**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                  Type          Description
>   -------------------------- ------------- ----------------------------------------------------------------------------
>   `name`                     string        The name for the profile
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "name": "CCR_TOP"
>         }
>      ]
>     }

| 

**GET /api/1.1/profiles/:id**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
> +---------------+----------+-------------------------------------------+
> | Parameter     | Required | Description                               |
> +===============+==========+===========================================+
> | `id`          | > yes    | The ID of the profile.                    |
> +---------------+----------+-------------------------------------------+
>
> **Response Properties**
>
>   Parameter                      Type            Description
>   ------------------------------ --------------- ----------------------------------------------------------------------------------------
>   `lastUpdated`                  array           The Time / Date this server entry was last updated
>   `name`                         string          The name for the profile
>   `id`                           string          Primary key
>   `description`                  string          The description for the profile
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "lastUpdated": "2012-10-08 19:34:45",
>             "name": "CCR_TOP",
>             "id": "8",
>             "description": "Content Router for top.foobar.net"
>         }
>      ]
>     }

| 
