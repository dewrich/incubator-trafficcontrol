InfluxDB
========

<div class="admonition note">

The documentation needs a thorough review!

</div>

**GET /api/1.2/traffic\_monitor/stats.json**

Authentication Required: Yes

Role(s) Required: None

**Response Properties**

  Parameter                         Type          Description
  --------------------------------- ------------- ----------------------------------------------------------------------
  `aaData`                          array         

**Response Example** :

    {
     "aaData": [
        [
           "0",
           "ALL",
           "ALL",
           "ALL",
           "true",
           "ALL",
           "142035",
           "172365661.85"
        ],
        [
           1,
           "EDGE1_TOP_421_PSPP",
           "odol-atsec-atl-03",
           "us-ga-atlanta",
           "1",
           "REPORTED",
           "596",
           "923510.04",
           "69.241.82.126"
        ]
     ],
    }
