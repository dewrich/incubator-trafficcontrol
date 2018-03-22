Federation Federation Resolver
==============================

/api/1.2/federations/:id/federation\_resolvers
----------------------------------------------

**GET /api/1.2/federations/:id/federation\_resolvers**

> Retrieves federation resolvers assigned to a federation.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                      Type           Description
>   ------------------------- -------------- --------------------------------------------------------------
>   `federation`              string         Federation ID.
>
> **Response Properties**
>
> +-----------------+------+--------------------------------------------+
> | Parameter       | Type | Description                                |
> +=================+======+============================================+
> | `id`            | > in |                                            |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `ipAddress`     | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `type`          | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": 41
>             "ipAddress": "2.2.2.2/16",
>             "type": "RESOLVE4"
>         }
>       ]
>     }

| 

**POST /api/1.2/federations/:id/federation\_resolvers**

> Create one or more federation / federation resolver assignments.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Parameters**
>
>   Name                                                    Required           Description
>   ------------------------------------------------------- ------------------ ---------------------------------------------------------------------------------------------------------------
>   `fedResolverIds`                                        yes                An array of federation resolver IDs.
>   `replace`                                               no                 Replace existing fed/ds assignments? (true|false)
>
> **Request Example** :
>
>     {
>         "fedResolverIds": [ 2, 3, 4, 5, 6 ],
>         "replace": true
>     }
>
> **Response Properties**
>
>   Parameter                                                                  Type               Description
>   -------------------------------------------------------------------------- ------------------ ----------------------------------------------------------------------------------------------------------------------------------------
>   `fedResolverIds`                                                           array              An array of federation resolver IDs.
>   `replace`                                                                  array              Existing fed/fed resolver assignments replaced? (true|false).
>
> **Response Example** :
>
>     {
>         "alerts": [
>                   {
>                           "level": "success",
>                           "text": "5 resolvers(s) were assigned to the cname. federation"
>                   }
>           ],
>         "response": {
>             "fedResolverIds" : [ 2, 3, 4, 5, 6 ],
>             "replace" : true
>         }
>     }

| 
