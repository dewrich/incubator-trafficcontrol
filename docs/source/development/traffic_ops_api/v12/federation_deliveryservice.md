Federation Delivery Service
===========================

/api/1.2/federations/:id/deliveryservices
-----------------------------------------

**GET /api/1.2/federations/:id/deliveryservices**

> Retrieves delivery services assigned to a federation.
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
> | `cdn`           | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `type`          | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `xmlId`         | stri |                                            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": 41
>             "cdn": "cdn1",
>             "type": "DNS",
>             "xmlId": "booya-12"
>         }
>       ]
>     }

| 

**POST /api/1.2/federations/:id/deliveryservices**

> Create one or more federation / delivery service assignments.
>
> Authentication Required: Yes
>
> Role(s) Required: Admin
>
> **Request Parameters**
>
>   Name                                        Required       Description
>   ------------------------------------------- -------------- --------------------------------------------------------------------------------------
>   `dsIds`                                     yes            An array of delivery service IDs.
>   `replace`                                   no             Replace existing fed/ds assignments? (true|false)
>
> **Request Example** :
>
>     {
>         "dsIds": [ 2, 3, 4, 5, 6 ],
>         "replace": true
>     }
>
> **Response Properties**
>
>   Parameter                                                     Type            Description
>   ------------------------------------------------------------- --------------- -----------------------------------------------------------------------------------------------------------------
>   `dsIds`                                                       array           An array of delivery service IDs.
>   `replace`                                                     array           Existing fed/ds assignments replaced? (true|false).
>
> **Response Example** :
>
>     {
>         "alerts": [
>                   {
>                           "level": "success",
>                           "text": "5 delivery service(s) were assigned to the cname. federation"
>                   }
>           ],
>         "response": {
>             "dsIds" : [ 2, 3, 4, 5, 6 ],
>             "replace" : true
>         }
>     }

| 

**DELETE /api/1.2/federations/:id/deliveryservices/:id**

> Removes a delivery service from a federation.
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
>   `ds`                   yes            Delivery Service ID.
>
> > **Response Example** :
> >
> >     {
> >            "alerts": [
> >                      {
> >                              "level": "success",
> >                              "text": "Removed delivery service [ booya-12 ] from federation [ cname1. ]"
> >                      }
> >              ],
> >     }

| 
