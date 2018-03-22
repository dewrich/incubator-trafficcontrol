Cache Statistics
================

/api/1.2/cache\_stats
---------------------

**GET /api/1.2/cache\_stats.json**

> Retrieves statistics about the CDN.
>
> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
>   Name                                                                                                                                      Required                                                 Description
>   ----------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>   `cdnName`                                                                                                                                 yes                                                      The CDN name to return cache stats for
>   `metricType`                                                                                                                              yes                                                      The metric type (valid metric types: 'ats.proxy.process.http.current\_client\_connections', 'bandwidth', 'maxKbps')
>   `startDate`                                                                                                                               yes                                                      The begin date (Formatted as ISO8601, for example: '2015-08-11T12:30:00-06:00')
>   `endDate`                                                                                                                                 yes                                                      The end date (Formatted as ISO8601, for example: '2015-08-12T12:30:00-06:00')
>
> **Response Properties**
>
>   Parameter                                        Type                        Description
>   ------------------------------------------------ --------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------
>   `summary`                                        hash                        Summary data
>   `>count`                                         int                         
>   `>min`                                           float                       
>   `>max`                                           float                       
>   `>fifthPercentile`                               float                       
>   `>ninetyEighthPercentile`                        float                       
>   `>ninetyFifthPercentile`                         float                       
>   `>average`                                       float                       
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
>             "series": {
>                 "columns": [
>                     "time",
>                     ""
>                 ],
>                 "count": 29,
>                 "name": "bandwidth",
>                 "tags": {
>                     "cdn": "over-the-top"
>                 },
>                 "values": [
>                     [
>                         "2015-08-10T22:40:00Z",
>                         229340299720
>                     ],
>                     [
>                         "2015-08-10T22:41:00Z",
>                         224309221713.334
>                     ],
>                     [
>                         "2015-08-10T22:42:00Z",
>                         229551834168.334
>                     ],
>                     [
>                         "2015-08-10T22:43:00Z",
>                         225179658876.667
>                     ],
>                     [
>                         "2015-08-10T22:44:00Z",
>                         230443968275
>                     ]
>                 ]
>             },
>             "summary": {
>                 "average": 970410.295,
>                 "count": 1376041798,
>                 "fifthPercentile": 202.03,
>                 "max": 3875441.02,
>                 "min": 0,
>                 "ninetyEighthPercentile": 2957940.93,
>                 "ninetyFifthPercentile": 2366728.63
>             }
>         }
>     }

| 
