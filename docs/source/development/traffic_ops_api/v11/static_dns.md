Static DNS Entries
==================

/api/1.1/staticdnsentries
-------------------------

**GET /api/1.1/staticdnsentries.json**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                          Type                Description
>   ---------------------------------- ------------------- ------------------------------------------------------------------------------------------------
>   `deliveryservice`                  string              
>   `ttl`                              string              
>   `type`                             string              
>   `address`                          string              
>   `cachegroup`                       string              
>   `host`                             string              
>
> **Response Example** :
>
>     {
>      "response": [
>        {
>          "deliveryservice": "foo-ds",
>          "ttl": "30",
>          "type": "CNAME_RECORD",
>          "address": "bar.foo.baz.tv.",
>          "cachegroup": "us-co-denver",
>          "host": "mm"
>        }
>      ]
>
> > }
