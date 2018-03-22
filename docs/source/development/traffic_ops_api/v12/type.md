Types
=====

/api/1.2/types
--------------

**GET /api/1.1/types**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
>   Name                  Required       Description
>   --------------------- -------------- -------------------------------------------------------------------
>   `useInTable`          no             Filter types by the table in which they apply
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `id`                                   string          
>   `name`                                 string          
>   `description`                          string          
>   `useInTable`                           string          
>   `lastUpdated`                          string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": "22",
>            "name": "AAAA_RECORD",
>            "description": "Static DNS AAAA entry",
>            "useInTable": "staticdnsentry",
>            "lastUpdated": "2013-10-23 15:28:31"
>         }
>      ]
>     }

| 

**GET /api/1.1/types/trimmed**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                         Type          Description
>   --------------------------------- ------------- ----------------------------------------------------------------------
>   `name`                            string        
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "name": "AAAA_RECORD"
>         },
>         {
>            "name": "ACTIVE_DIRECTORY"
>         },
>         {
>            "name": "A_RECORD"
>         },
>         {
>            "name": "CCR"
>         }
>      ],
>     }

**GET /api/1.1/types/:id**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                 Required      Description
>   -------------------- ------------- --------------------------------------------------------------
>   `id`                 yes           Type ID.
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `id`                                   string          
>   `name`                                 string          
>   `description`                          string          
>   `useInTable`                           string          
>   `lastUpdated`                          string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": "22",
>            "name": "AAAA_RECORD",
>            "description": "Static DNS AAAA entry",
>            "useInTable": "staticdnsentry",
>            "lastUpdated": "2013-10-23 15:28:31"
>         }
>      ]
>     }

| 
