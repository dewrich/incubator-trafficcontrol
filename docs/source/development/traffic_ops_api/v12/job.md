Jobs
====

/api/1.2/jobs
-------------

**GET /api/1.2/jobs**

> Get all jobs (currently limited to invalidate content (PURGE) jobs)
> sorted by start time (descending).
>
> Authentication Required: Yes
>
> Role(s) Required: Operations or Admin
>
> **Request Query Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- -------------------------------------------------------------
>   `dsId`                no            Filter jobs by Delivery Service ID.
>   `userId`              no            Filter jobs by User ID.
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Job id                                   |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `assetUrl`        | stri | URL of the asset to invalidate.          |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `deliveryService` | stri | Unique identifier of the job's DS.       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `keyword`         | stri | Job keyword (PURGE)                      |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `parameters`      | stri | Parameters associated with the job.      |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `startTime`       | stri | Start time of the job.                   |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `createdBy`       | stri | Username that initiated the job.         |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": 1
>            "assetUrl": "http:\/\/foo-bar.domain.net\/taco.html",
>            "deliveryService": "foo-bar",
>            "keyword": "PURGE",
>            "parameters": "TTL:48h",
>            "startTime": "2015-05-14 08:56:36-06",
>            "createdBy": "jdog24"
>         },
>         {
>            "id": 2
>            "assetUrl": "http:\/\/foo-bar.domain.net\/bell.html",
>            "deliveryService": "foo-bar",
>            "keyword": "PURGE",
>            "parameters": "TTL:72h",
>            "startTime": "2015-05-16 08:56:36-06",
>            "createdBy": "jdog24"
>         }
>      ]
>     }

| 

**GET /api/1.2/jobs/:id**

> Get a job by ID (currently limited to invalidate content (PURGE)
> jobs).
>
> Authentication Required: Yes
>
> Role(s) Required: Operations or Admin
>
> **Response Properties**
>
> +-------------------+------+------------------------------------------+
> | Parameter         | Type | Description                              |
> +===================+======+==========================================+
> | `id`              | > in | Job id                                   |
> |                   | t    |                                          |
> +-------------------+------+------------------------------------------+
> | `assetUrl`        | stri | URL of the asset to invalidate.          |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `deliveryService` | stri | Unique identifier of the job's DS.       |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `keyword`         | stri | Job keyword (PURGE)                      |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `parameters`      | stri | Parameters associated with the job.      |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `startTime`       | stri | Start time of the job.                   |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
> | `createdBy`       | stri | Username that initiated the job.         |
> |                   | ng   |                                          |
> +-------------------+------+------------------------------------------+
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "id": 1
>            "assetUrl": "http:\/\/foo-bar.domain.net\/taco.html",
>            "deliveryService": "foo-bar",
>            "keyword": "PURGE",
>            "parameters": "TTL:48h",
>            "startTime": "2015-05-14 08:56:36-06",
>            "createdBy": "jdog24"
>         }
>      ]
>     }

| 
