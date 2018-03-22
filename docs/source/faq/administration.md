Running a Traffic Control CDN
=============================

Why is my CRConfig.json rejected?
---------------------------------

> Especially in version 1.1.0, there's a number of manual steps that
> need to be done after the initial install. Make sure that after the
> initial install, you perform these steps in order:
>
> <div class="admonition note">
>
> Even though Traffic Ops allows you to enter the servers with no IPv6
> address information, the CRConfig will not be accepted by Traffic
> Router without IPv6 address information for at least Traffic Router
> and Traffic Monitor. Traffic Control assumes in a lot of places that
> all servers have at least an IPv4 and an IPv6 address. If you are not
> using IPv6, it is best to enter dummy addresses for all server types,
> and turn IPv6 off in all delivery services.
> (<https://github.com/Comcast/traffic_control/issues/44>).
>
> </div>
>
> -   
>
>     Add users
>
>     :   Not necessarily needed for getting your CRConfig accepted, but
>         always a good idea.
>
> -   
>
>     Add Divisions
>
>     :   You will need at least one.
>
> -   
>
>     Add Regions
>
>     :   You will need at least one.
>
> -   
>
>     Add Physical Locations
>
>     :   You will need at least one.
>
> -   
>
>     Add Mid tier Cache Groups
>
>     :   You will need at least one.
>
> -   
>
>     Add Edge tier Cache Groups
>
>     :   You will need at least one.
>
> -   
>
>     Add Traffic Monitors
>
>     :   You will need to enter at least one Traffic Monitor - make
>         sure to change the server status to *ONLINE*.
>
> -   
>
>     Add Traffic Routers
>
>     :   You will need to enter at least one Traffic Router - make sure
>         to change the server status to *ONLINE*.
>
> -   
>
>     Add Edges
>
>     :   You will need at least one edge cache to make Traffic Router
>         accept the CRConfig.
>
> -   
>
>     Add Mid
>
>     :   Technically you don't need a mid tier, but if you have one,
>         best to enter the info before continuing.
>
> -   
>
>     Change the `polling.url` parameters to reflect your CDN
>
>     :   Set where to get the coverage zone map, and the geo IP
>         database.
>
> -   
>
>     Create at least one delivery service, and assign at least one edge cache in REPORTED state to it.
>
>     :   Even if it is a dummy DS, without a single DS, the CRConfig
>         will not be accepted by Traffic Router.
>
> -   
>
>     Snapshot CRConfig
>
>     :   **Tools &gt; Snapshot CRConfig** diff, and write.
>
> Now you are ready to install the sw on Traffic Monitor and then
> Traffic Router.
