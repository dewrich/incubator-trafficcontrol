Federation User
===============

/api/1.2/federations/:id/users
------------------------------

**GET /api/1.2/federations/:id/users**

> Retrieves users assigned to a federation.
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
> | `company`       | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `id`            | > in |                                            |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `username`      | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `role`          | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `email`         | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `fullName`      | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": 41
>             "username": "booya",
>             "company": "XYZ Corporation",
>             "role": "federation",
>             "email": "booya@fooya.com",
>             "fullName": "Booya Fooya"
>         }
>       ]
>     }

| 

**POST /api/1.2/federations/:id/users**

> Create one or more federation / user assignments.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Parameters**
>
>   Name                                        Required       Description
>   ------------------------------------------- -------------- --------------------------------------------------------------------------------------
>   `userIds`                                   yes            An array of user IDs.
>   `replace`                                   no             Replace existing fed/user assignments? (true|false)
>
> **Request Example** :
>
>     {
>         "userIds": [ 2, 3, 4, 5, 6 ],
>         "replace": true
>     }
>
> **Response Properties**
>
>   Parameter                                                     Type            Description
>   ------------------------------------------------------------- --------------- -----------------------------------------------------------------------------------------------------------------
>   `userIds`                                                     array           An array of user IDs.
>   `replace`                                                     array           Existing fed/user assignments replaced? (true|false).
>
> **Response Example** :
>
>     {
>         "alerts": [
>                   {
>                           "level": "success",
>                           "text": "5 user(s) were assigned to the cname. federation"
>                   }
>           ],
>         "response": {
>             "userIds" : [ 2, 3, 4, 5, 6 ],
>             "replace" : true
>         }
>     }

| 

**DELETE /api/1.2/federations/:id/users/:id**

> Removes a user from a federation.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Route Parameters**
>
>   Name                   Required       Description
>   ---------------------- -------------- ------------------------------------------------------------------
>   `federation`           yes            Federation ID.
>   `user`                 yes            User ID.
>
> > **Response Example** :
> >
> >     {
> >            "alerts": [
> >                      {
> >                              "level": "success",
> >                              "text": "Removed user [ bobmack ] from federation [ cname1. ]"
> >                      }
> >              ],
> >     }

| 
