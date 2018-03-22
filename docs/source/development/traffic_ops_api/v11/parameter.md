Parameter
=========

/api/1.1/parameters
-------------------

**GET /api/1.1/parameters.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                      Type             Description
>   ------------------------------ ---------------- ---------------------------------------------------------------------------------------------------------------------------------
>   `last_updated`                 string           The Time / Date this server entry was last updated
>   `secure`                       boolean          When true, the parameter is accessible only by admin users. Defaults to false.
>   `value`                        string           The parameter value, only visible to admin if secure is true
>   `name`                         string           The parameter name
>   `config_file`                  string           The parameter config\_file
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "foo.bar.net",
>            "name": "domain_name",
>            "config_file": "FooConfig.xml"
>         },
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "0,1,2,3,4,5,6",
>            "name": "Drive_Letters",
>            "config_file": "storage.config"
>         },
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "STRING __HOSTNAME__",
>            "name": "CONFIG proxy.config.proxy_name",
>            "config_file": "records.config"
>         }
>      ],
>     }

| 

**GET /api/1.1/parameters/profile/:name.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name                        Required         Description
>   --------------------------- ---------------- --------------------
>   `profile_name`              yes              
>
> **Response Properties**
>
>   Parameter                      Type             Description
>   ------------------------------ ---------------- ---------------------------------------------------------------------------------------------------------------------------------
>   `last_updated`                 string           The Time / Date this server entry was last updated
>   `secure`                       boolean          When true, the parameter is accessible only by admin users. Defaults to false.
>   `value`                        string           The parameter value, only visible to admin if secure is true
>   `name`                         string           The parameter name
>   `config_file`                  string           The parameter config\_file
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "foo.bar.net",
>            "name": "domain_name",
>            "config_file": "FooConfig.xml"
>         },
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "0,1,2,3,4,5,6",
>            "name": "Drive_Letters",
>            "config_file": "storage.config"
>         },
>         {
>            "last_updated": "2012-09-17 21:41:22",
>            "secure": 0,
>            "value": "STRING __HOSTNAME__",
>            "name": "CONFIG proxy.config.proxy_name",
>            "config_file": "records.config"
>         }
>      ],
>     }
