Federation Resolver
===================

/api/1.2/federation\_resolvers
------------------------------

**POST /api/1.2/federation\_resolvers**

> Create a federation resolver.
>
> Authentication Required: Yes
>
> Role(s) Required: ADMIN
>
> **Request Properties**
>
>   Parameter                                              Required                Description
>   ------------------------------------------------------ ----------------------- -----------------------------------------------------------------------------------------
>   `ipAddress`                                            yes                     IP or CIDR range
>   `typeId`                                               yes                     Type Id where useintable=federation
>
> **Request Example** :
>
>     {
>         "ipAddress": "2.2.2.2/32",
>         "typeId": 245
>     }

| 

> **Response Properties**
>
>   Parameter                         Type          Description
>   --------------------------------- ------------- ----------------------------------------------------------------------
>   `id`                              int           
>   `ipAddress`                       string        
>   `type`                            int           
>
> **Response Example** :
>
>     {
>         "alerts": [
>                   {
>                           "level": "success",
>                           "text": "Federation resolver created [ IP = 2.2.2.2/32 ] with id: 27"
>                   }
>           ],
>         "response": {
>             "id" : 27,
>             "ipAddress" : "2.2.2.2/32",
>             "typeId" : 245,
>         }
>     }

| 

**DELETE /api/1.2/federation\_resolvers/:id**

> Deletes a federation resolver.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Route Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- -------------------------------------------------------------
>   `resolver`            yes           Federation resolver ID.
>
> > **Response Example** :
> >
> >     {
> >            "alerts": [
> >                      {
> >                              "level": "success",
> >                              "text": "Federation resolver deleted [ IP = 2.2.2.2/32 ] with id: 27"
> >                      }
> >              ],
> >     }

| 
