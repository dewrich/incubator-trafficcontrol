Physical Location
=================

/api/1.2/phys\_locations
------------------------

**GET /api/1.2/phys\_locations**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
> +--------------+----------+---------------------------------------------+
> | Name         | Required | Description                                 |
> +==============+==========+=============================================+
> | > `region`   | no       | Filter by Region ID.                        |
> +--------------+----------+---------------------------------------------+
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `address`                              string          
>   `city`                                 string          
>   `comments`                             string          
>   `email`                                string          
>   `id`                                   string          
>   `lastUpdated`                          string          
>   `name`                                 string          
>   `phone`                                string          
>   `poc`                                  string          
>   `region`                               string          
>   `regionId`                             string          
>   `shortName`                            string          
>   `state`                                string          
>   `zip`                                  string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "region": "Mile High",
>            "region": "4",
>            "poc": "Jane Doe",
>            "lastUpdated": "2014-10-02 08:22:43",
>            "name": "Albuquerque",
>            "comments": "Albuquerque",
>            "phone": "(123) 555-1111",
>            "state": "NM",
>            "email": "jane.doe@email.com",
>            "city": "Albuquerque",
>            "zip": "87107",
>            "id": "2",
>            "address": "123 East 3rd St",
>            "shortName": "Albuquerque"
>         },
>         {
>            "region": "Mile High",
>            "region": "4",
>            "poc": "Jane Doe",
>            "lastUpdated": "2014-10-02 08:22:43",
>            "name": "Albuquerque",
>            "comments": "Albuquerque",
>            "phone": "(123) 555-1111",
>            "state": "NM",
>            "email": "jane.doe@email.com",
>            "city": "Albuquerque",
>            "zip": "87107",
>            "id": "2",
>            "address": "123 East 3rd St",
>            "shortName": "Albuquerque"
>         }
>      ]
>     }

| 

**GET /api/1.2/phys\_locations/trimmed.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                     Type          Description
>   ----------------------------- ------------- ---------------------------------------------------------------
>   `name`                        string        
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "name": "Albuquerque"
>         },
>         {
>            "name": "Ashburn"
>         }
>      ]
>     }

| 

**GET /api/1.2/phys\_locations/:id**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name           Required      Description
>   -------------- ------------- ------------------------------------------------------
>   `id`           yes           Physical location ID.
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `address`                              string          
>   `city`                                 string          
>   `comments`                             string          
>   `email`                                string          
>   `id`                                   string          
>   `lastUpdated`                          string          
>   `name`                                 string          
>   `phone`                                string          
>   `poc`                                  string          
>   `region`                               string          
>   `regionId`                             string          
>   `shortName`                            string          
>   `state`                                string          
>   `zip`                                  string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "region": "Mile High",
>            "region": "4",
>            "poc": "Jane Doe",
>            "lastUpdated": "2014-10-02 08:22:43",
>            "name": "Albuquerque",
>            "comments": "Albuquerque",
>            "phone": "(123) 555-1111",
>            "state": "NM",
>            "email": "jane.doe@email.com",
>            "city": "Albuquerque",
>            "zip": "87107",
>            "id": "2",
>            "address": "123 East 3rd St",
>            "shortName": "Albuquerque"
>         }
>      ]
>     }

| 

**PUT /api/1.2/phys\_locations/:id**

:   Update a physical location

    Authentication Required: Yes

    Role(s) Required: admin or oper

    **Request Route Parameters**

      Name                    Type          Description
      ----------------------- ------------- ---------------------------------------------------------
      `id`                    int           Physical location id.

    **Request Properties**

    +-----------------+--------+-------------------------------------------+
    | Parameter       | Requir | Description                               |
    |                 | ed     |                                           |
    +=================+========+===========================================+
    | `address`       | > yes  | Physical location address.                |
    +-----------------+--------+-------------------------------------------+
    | `city`          | > yes  | Physical location city.                   |
    +-----------------+--------+-------------------------------------------+
    | `comments`      | > no   | Physical location comments.               |
    +-----------------+--------+-------------------------------------------+
    | `email`         | > no   | Physical location email.                  |
    +-----------------+--------+-------------------------------------------+
    | `name`          | > yes  | Physical location name.                   |
    +-----------------+--------+-------------------------------------------+
    | `phone`         | > no   | Physical location phone.                  |
    +-----------------+--------+-------------------------------------------+
    | `poc`           | > no   | Physical location point of contact.       |
    +-----------------+--------+-------------------------------------------+
    | `regionId`      | > no   | Physical location region ID.              |
    +-----------------+--------+-------------------------------------------+
    | `shortName`     | > yes  | Physical location short name.             |
    +-----------------+--------+-------------------------------------------+
    | `state`         | > yes  | Physical location state.                  |
    +-----------------+--------+-------------------------------------------+
    | `zip`           | > yes  | Physical location zip.                    |
    +-----------------+--------+-------------------------------------------+

    **Request Example** :

        {
           "regionId": "1",
           "poc": "Jane Doesssss",
           "name": "Albuquerque",
           "comments": "Albuquerque",
           "phone": "(123) 555-1111",
           "state": "NM",
           "email": "jane.doe@email.com",
           "city": "Albuquerque",
           "zip": "87107",
           "address": "123 East 9rd St",
           "shortName": "Albuquerque"
        }

| 

> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `address`                              string          
>   `city`                                 string          
>   `comments`                             string          
>   `email`                                string          
>   `id`                                   string          
>   `lastUpdated`                          string          
>   `name`                                 string          
>   `phone`                                string          
>   `poc`                                  string          
>   `region`                               string          
>   `regionId`                             string          
>   `shortName`                            string          
>   `state`                                string          
>   `zip`                                  string          
>
> **Response Example** :
>
>     {
>      "alerts": [
>         {
>             "level": "success",
>             "text": "Physical location update was successful."
>         }
>       ],
>      "response": [
>         {
>            "region": "Mile High",
>            "region": "4",
>            "poc": "Jane Doe",
>            "lastUpdated": "2014-10-02 08:22:43",
>            "name": "Albuquerque",
>            "comments": "Albuquerque",
>            "phone": "(123) 555-1111",
>            "state": "NM",
>            "email": "jane.doe@email.com",
>            "city": "Albuquerque",
>            "zip": "87107",
>            "id": "2",
>            "address": "123 East 3rd St",
>            "shortName": "Albuquerque"
>         }
>      ]
>     }

| 

**POST /api/1.2/regions/:region\_name/phys\_locations**

:   Create physical location.

    Authentication Required: Yes

    Role(s) Required: admin or oper

    region\_name: the name of the region to create physical location
    into.

    **Request Route Parameters**

      Name                     Required        Description
      ------------------------ --------------- -------------------------------------------------
      `region_name`            yes             The name of the physical location

    **Request Properties**

      Parameter             Required      Description
      --------------------- ------------- -------------------------------------------------------------
      `name`                yes           The name of the location
      `shortName`           yes           The short name of the location
      `address`             yes           
      `city`                yes           
      `state`               yes           
      `zip`                 yes           
      `phone`               no            
      `poc`                 no            Point of contact
      `email`               no            
      `comments`            no            

    **Request Example** :

        {
            "name" : "my physical location1",
            "shortName" : "myphylocation1",
            "address" : "",
            "city" : "Shanghai",
            "state": "SH",
            "zip": "200000",
            "comments": "this is physical location1"
        }

| 

> **Response Properties**
>
>   Parameter                    Type           Description
>   ---------------------------- -------------- --------------------------------------------------------------------------------
>   `id`                         string         The id of the physical location created.
>   `name`                       string         The name of the location
>   `shortName`                  string         The short name of the location
>   `regionName`                 string         The region name the physical location belongs to.
>   `regionId`                   string         
>   `address`                    string         
>   `city`                       string         
>   `state`                      string         
>   `zip`                        string         
>   `phone`                      string         
>   `poc`                        string         Point of contact
>   `email`                      string         
>   `comments`                   string         
>
> **Response Example** :
>
>     {
>       "response": {
>         'shortName': 'myphylocati',
>         'regionName': 'myregion1',
>         'name': 'my physical location1',
>         'poc': '',
>         'phone': '',
>         'comments': 'this is physical location1',
>         'state': 'SH',
>         'email': '',
>         'zip': '20000',
>         'region_id': '20',
>         'city': 'Shanghai',
>         'address': '',
>         'id': '200'
>      }
>
> > }

| 
