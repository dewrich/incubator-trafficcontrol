Roles
=====

/api/1.1/roles
--------------

**GET /api/1.1/roles.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `name`                                 string          
>   `id`                                   string          
>   `privLevel`                            string          
>   `description`                          string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "name": "read-only",
>            "id": "2",
>            "privLevel": "10",
>            "description": "read-only user"
>         }
>      ],
>     }
