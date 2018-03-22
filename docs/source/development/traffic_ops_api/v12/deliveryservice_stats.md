Delivery Service Statistics
===========================

/api/1.2/deliveryservice\_stats
-------------------------------

**GET /api/1.2/deliveryservice\_stats.json**

> Retrieves statistics on the delivery services. See also [Using Traffic
> Ops - Delivery
> Service](http://trafficcontrol.apache.org/docs/latest/admin/traffic_ops_using.html#delivery-service).
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
>   Name                                                                      Required                       Description
>   ------------------------------------------------------------------------- ------------------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>   `deliveryServiceName`                                                     yes                            The delivery service with the desired stats
>   `metricType`                                                              yes                            The metric type (valid metric types: 'kbps', 'out\_bytes', 'status\_4xx', 'status\_5xx', tps\_total', 'tps\_2xx','tps\_3xx', 'tps\_4xx', 'tps\_5xx')
>   `startDate`                                                               yes                            The begin date (Formatted as ISO8601, for example: '2015-08-11T12:30:00-06:00')
>   `endDate`                                                                 yes                            The end date (Formatted as ISO8601, for example: '2015-08-12T12:30:00-06:00')
>
> **Response Properties**
>
>   Parameter                                        Type                        Description
>   ------------------------------------------------ --------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------
>   `source`                                         string                      The source of the data
>   `summary`                                        hash                        Summary data
>   `>totalBytes`                                    float                       
>   `>count`                                         int                         
>   `>min`                                           float                       
>   `>max`                                           float                       
>   `>fifthPercentile`                               float                       
>   `>ninetyEighthPercentile`                        float                       
>   `>ninetyFifthPercentile`                         float                       
>   `>average`                                       float                       
>   `>totalTransactions`                             int                         
>   `series`                                         hash                        Series data
>   `>count`                                         int                         
>   `>columns`                                       array                       
>   `>name`                                          string                      
>   `>values`                                        array                       
>   `>>time`                                         string                      
>   `>>value`                                        float                       
>
> **Response Example** :
>
>     {
>         "response": {
>             "source": "TrafficStats",
>             "summary": {
>                 "average": 1081172.785,
>                 "count": 28,
>                 "fifthPercentile": 888827.26,
>                 "max": 1326680.31,
>                 "min": 888827.26,
>                 "ninetyEighthPercentile": 1324785.47,
>                 "ninetyFifthPercentile": 1324785.47,
>                 "totalBytes": 37841047.475,
>                 "totalTransactions": 1020202030101
>             },
>             "series": {
>                 "columns": [
>                     "time",
>                     ""
>                 ],
>                 "count": 60,
>                 "name": "kbps",
>                 "tags": {
>                     "cachegroup": "total"
>                 },
>                 "values": [
>                     [
>                         "2015-08-11T11:36:00Z",
>                         888827.26
>                     ],
>                     [
>                         "2015-08-11T11:37:00Z",
>                         980336.563333333
>                     ],
>                     [
>                         "2015-08-11T11:38:00Z",
>                         952111.975
>                     ],
>                     [
>                         "2015-08-11T11:39:00Z",
>                         null
>                     ],
>                     [
>                         "2015-08-11T11:43:00Z",
>                         null
>                     ],
>                     [
>                         "2015-08-11T11:44:00Z",
>                         934682.943333333
>                     ],
>                     [
>                         "2015-08-11T11:45:00Z",
>                         1251121.28
>                     ],
>                     [
>                         "2015-08-11T11:46:00Z",
>                         1111012.99
>                     ]
>                 ]
>             }
>         }
>     }

| 
