Profiles
========

/api/1.2/profiles
-----------------

**GET /api/1.2/profiles**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
> +-------------+--------+----------------------------------------------+
> | Name        | Requir | Description                                  |
> |             | ed     |                                              |
> +=============+========+==============================================+
> | `param`     | > no   | Used to filter profiles by parameter ID.     |
> +-------------+--------+----------------------------------------------+
> | `cdn`       | > no   | Used to filter profiles by CDN ID.           |
> +-------------+--------+----------------------------------------------+
>
> **Response Properties**
>
> +-----------------+------+---------------------------------------------+
> | Parameter       | Type | Description                                 |
> +=================+======+=============================================+
> | `id`            | stri | Primary key                                 |
> |                 | ng   |                                             |
> +-----------------+------+---------------------------------------------+
> | `name`          | stri | The name for the profile                    |
> |                 | ng   |                                             |
> +-----------------+------+---------------------------------------------+
> | `description`   | stri | The description for the profile             |
> |                 | ng   |                                             |
> +-----------------+------+---------------------------------------------+
> | `cdn`           | > in | The CDN ID                                  |
> |                 | t    |                                             |
> +-----------------+------+---------------------------------------------+
> | `cdnName`       | stri | The CDN name                                |
> |                 | ng   |                                             |
> +-----------------+------+---------------------------------------------+
> | `type`          | stri | Profile type                                |
> |                 | ng   |                                             |
> +-----------------+------+---------------------------------------------+
> | `routingDisable | > bo | Traffic router routing disabled - defaults  |
> | d`              | ol   | to false.                                   |
> +-----------------+------+---------------------------------------------+
> | `lastUpdated`   | arra | The Time / Date this server entry was last  |
> |                 | y    | updated                                     |
> +-----------------+------+---------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": "8",
>             "name": "EDGE_27_PROFILE",
>             "description": "A profile with all the Foo parameters"
>             "cdn": 1
>             "cdnName": "cdn1"
>             "type": "ATS_PROFILE"
>             "routingDisabled": false
>             "lastUpdated": "2012-10-08 19:34:45",
>         }
>      ]
>     }

| 

**GET /api/1.2/profiles/trimmed**

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
>             "name": "EDGE_27_PROFILE"
>         }
>      ]
>     }

| 

**GET /api/1.2/profiles/:id**

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
> +-----------------+------+--------------------------------------------+
> | Parameter       | Type | Description                                |
> +=================+======+============================================+
> | `id`            | stri | Primary key                                |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `name`          | stri | The name for the profile                   |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `description`   | stri | The description for the profile            |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `cdn`           | > in | The CDN ID                                 |
> |                 | t    |                                            |
> +-----------------+------+--------------------------------------------+
> | `cdnName`       | stri | The CDN name                               |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `type`          | stri | Profile type                               |
> |                 | ng   |                                            |
> +-----------------+------+--------------------------------------------+
> | `routingDisable | > bo | Traffic router routing disabled            |
> | d`              | ol   |                                            |
> +-----------------+------+--------------------------------------------+
> | `lastUpdated`   | arra | The Time / Date this server entry was last |
> |                 | y    | updated                                    |
> +-----------------+------+--------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": "8",
>             "name": "EDGE_27_PROFILE",
>             "description": "A profile with all the Foo parameters"
>             "cdn": 1
>             "cdnName": "cdn1"
>             "type": "ATS_PROFILE"
>             "routingDisabled": true
>             "lastUpdated": "2012-10-08 19:34:45",
>         }
>      ]
>     }

| 

**POST /api/1.2/profiles**

:   Create a new empty profile.

    Authentication Required: Yes

    Role(s) Required: admin or oper

    **Request Properties**

    +-------------------+------+--------+----------------------------------+
    | Parameter         | Type | Requir | Description                      |
    |                   |      | ed     |                                  |
    +===================+======+========+==================================+
    | `name`            | stri | yes    | Profile name                     |
    |                   | ng   |        |                                  |
    +-------------------+------+--------+----------------------------------+
    | `description`     | stri | yes    | Profile description              |
    |                   | ng   |        |                                  |
    +-------------------+------+--------+----------------------------------+
    | `cdn`             | > in | no     | CDN ID                           |
    |                   | t    |        |                                  |
    +-------------------+------+--------+----------------------------------+
    | `type`            | stri | yes    | Profile type                     |
    |                   | ng   |        |                                  |
    +-------------------+------+--------+----------------------------------+
    | `routingDisabled` | > bo | no     | Traffic router routing disabled. |
    |                   | ol   |        | Defaults to false.               |
    +-------------------+------+--------+----------------------------------+

> **Request Example** :
>
>     {
>       "name": "EDGE_28_PROFILE",
>       "description": "EDGE_28_PROFILE description",
>       "cdn": 1,
>       "type": "ATS_PROFILE",
>       "routingDisabled": false
>     }

| 

> **Response Properties**
>
> +-------------------+------+-------------------------------------------+
> | Parameter         | Type | Description                               |
> +===================+======+===========================================+
> | `id`              | stri | Profile ID                                |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `name`            | stri | Profile name                              |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `description`     | stri | Profile description                       |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `cdn`             | > in | CDN ID                                    |
> |                   | t    |                                           |
> +-------------------+------+-------------------------------------------+
> | `type`            | stri | Profile type                              |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `routingDisabled` | > bo | Traffic router routing disabled           |
> |                   | ol   |                                           |
> +-------------------+------+-------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": "66",
>             "name": "EDGE_28_PROFILE",
>             "description": "EDGE_28_PROFILE description",
>             "cdn": 1,
>             "type": "ATS_PROFILE",
>             "routingDisabled": false
>         }
>      ]
>     }

| 

**POST /api/1.2/profiles/name/:profile\_name/copy/:profile\_copy\_from**

:   Copy profile to a new profile. The new profile name must not exist.

    Authentication Required: Yes

    Role(s) Required: admin or oper

    **Request Route Parameters**

      Name                                          Required              Description
      --------------------------------------------- --------------------- -------------------------------------------------------------
      `profile_name`                                yes                   The name of profile to copy
      `profile_copy_from`                           yes                   The name of profile copy from

    **Response Properties**

      Parameter                                          Type                Description
      -------------------------------------------------- ------------------- ---------------------------------------------------------------------------------------------------------------
      `id`                                               string              Id of the new profile
      `name`                                             string              The name of the new profile
      `profileCopyFrom`                                  string              The name of profile to copy
      `idCopyFrom`                                       string              The id of profile to copy
      `description`                                      string              new profile's description (copied)

> **Response Example** :
>
>     {
>      "response": [
>         {
>             "id": "66",
>             "name": "CCR_COPY",
>             "profileCopyFrom": "CCR1",
>             "description": "CCR_COPY description",
>             "idCopyFrom": "3"
>         }
>      ]
>     }

| 

**PUT /api/1.2/profiles/{:id}**

> Allows user to edit a profile.
>
> Authentication Required: Yes
>
> Role(s) Required: admin or oper
>
> **Request Route Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- -------------------------------------------------------------
>   `id`                  yes           profile id.
>
> **Request Properties**
>
> +------------------+------+-------+-----------------------------------+
> | Parameter        | Type | Requi | Description                       |
> |                  |      | red   |                                   |
> +==================+======+=======+===================================+
> | `name`           | stri | yes   | Profile name                      |
> |                  | ng   |       |                                   |
> +------------------+------+-------+-----------------------------------+
> | `description`    | stri | yes   | Profile description               |
> |                  | ng   |       |                                   |
> +------------------+------+-------+-----------------------------------+
> | `cdn`            | > in | no    | CDN ID - must use the same ID as  |
> |                  | t    |       | any servers assigned to the       |
> |                  |      |       | profile.                          |
> +------------------+------+-------+-----------------------------------+
> | `type`           | stri | yes   | Profile type                      |
> |                  | ng   |       |                                   |
> +------------------+------+-------+-----------------------------------+
> | `routingDisabled | > bo | no    | Traffic router routing disabled.  |
> | `                | ol   |       | When not present, value defaults  |
> |                  |      |       | to false.                         |
> +------------------+------+-------+-----------------------------------+
>
> **Request Example** :
>
>     {
>       "name": "EDGE_28_PROFILE",
>       "description": "EDGE_28_PROFILE description",
>       "cdn": 1,
>       "type": "ATS_PROFILE",
>       "routingDisabled": false
>     }

| 

> **Response Properties**
>
> +-------------------+------+-------------------------------------------+
> | Parameter         | Type | Description                               |
> +===================+======+===========================================+
> | `id`              | stri | Profile ID                                |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `name`            | stri | Profile name                              |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `description`     | stri | Profile description                       |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `cdn`             | > in | CDN ID                                    |
> |                   | t    |                                           |
> +-------------------+------+-------------------------------------------+
> | `type`            | stri | Profile type                              |
> |                   | ng   |                                           |
> +-------------------+------+-------------------------------------------+
> | `routingDisabled` | > bo | Traffic router routing disabled           |
> |                   | ol   |                                           |
> +-------------------+------+-------------------------------------------+
>
> **Response Example** :
>
>     {
>       "response":{
>         "id": "219",
>         "name": "EDGE_28_PROFILE",
>         "description": "EDGE_28_PROFILE description"
>         "cdn": 1
>         "type": "ATS_PROFILE",
>         "routingDisabled": false
>       }
>       "alerts":[
>         {
>           "level": "success",
>           "text": "Profile was updated: 219"
>         }
>       ]
>     }

| 

**DELETE /api/1.2/profiles/{:id}**

> Allows user to delete a profile.
>
> > Authentication Required: Yes
> >
> > Role(s) Required: admin or oper
> >
> > **Request Route Parameters**
> >
> >   Name                  Required      Description
> >   --------------------- ------------- ----------------------------------
> >   `id`                  yes           profile id.
> >
> > **Response Properties**
> >
> >   Parameter            Type          Description
> >   -------------------- ------------- --------------------------------------------------
> >   `alerts`             array         A collection of alert messages.
> >   `>level`             string        success, info, warning or error.
> >   `>text`              string        Alert message.
> >   `version`            string        
> >
> **Response Example** :
>
>     {
>       "alerts": [
>         {
>           "level": "success",
>           "text": "Profile was deleted."
>         }
>       ]
>     }

| 
