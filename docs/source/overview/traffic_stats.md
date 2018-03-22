Traffic Stats
=============

Traffic Stats is a program written in [Golang](http://golang.org) that
is used to acquire and store statistics about CDNs controlled by Traffic
Control. Traffic Stats mines metrics from Traffic Monitor's JSON APIs
and stores the data in [InfluxDb](http://influxdb.com). Data is
typically stored in InfluxDb on a short-term basis (30 days or less).
The data from InfluxDb is then used to drive graphs created by
[Grafana](http://grafana.org) - which are linked to from Traffic Ops -
as well as provide data exposed through the Traffic Ops API. Traffic
Stats performs two functions: first it gathers stat data for Edge Caches
and Delivery Services at a configurable interval (10 second default)
from the Traffic Monitor API's and stores the data in InfluxDb; second
it summarizes all of the stats once a day (around midnight UTC) and
creates a daily rollup containing the Max Gbps served and the Total
Bytes served.

Stat data is stored in three different databases:

> -   cache\_stats: The cache\_stats database is used to store data
>     gathered from edge caches. The
>     [measurements](https://influxdb.com/docs/v0.9/concepts/glossary.html#measurement)
>     stored by cache are: bandwidth, maxKbps, and client\_connections
>     (ats.proxy.process.http.current\_client\_connections). Cache Data
>     is stored with
>     [tags](https://influxdb.com/docs/v0.9/concepts/glossary.html#tag)
>     for hostname, cachegroup, and CDN. Data can be queried using tags.
> -   deliveryservice\_stats: The deliveryservice\_stats database is
>     used to store data for delivery services. The measurements stored
>     by delivery service are: kbps, status\_4xx, status\_5xx, tps\_2xx,
>     tps\_3xx, tps\_4xx, tps\_5xx, and tps\_total. Delivery Service
>     stats are stored with tags for cachegroup, CDN, and
>     Deliveryservice xml\_id.
> -   daily\_stats: The daily\_stats database is used to store summary
>     data for daily activities. The stats that are currently summarized
>     are Max Bandwidth and Bytes Served and they are stored by CDN.

------------------------------------------------------------------------

Traffic Stats does not influence overall CDN operation, but is required
in order to display charts in Traffic Ops and Traffic Portal.
