Traffic Server
==============

The caches in a Traffic Control CDN are servers running the Apache
Traffic Server software. See [ATS
documentation](http://trafficserver.readthedocs.org/en/latest/) for more
information. Caches in a Traffic Control CDN are deployed in cache
groups.

![arrow](fwda.png) Cache Group
------------------------------

> A cache group is a logical group of caches that Traffic Router tries
> to use as a combined cache. Traffic Router treats all servers in a
> cache group as though they are in the same physical location, though
> they are in fact only in the same region (network). A cache group has
> one single set of geographical coordinates even if the caches that
> make up the cache group are in different physical locations. The
> caches in a cache group are not aware of the other caches in the group
> - there is no clustering software or communications between caches in
> a cache group.
>
> There are two types of cache groups: EDGE and MID. Traffic Control is
> a two tier system, where the clients get directed to the EDGE cache
> group. On cache miss, the cache in the EDGE cache group obtains
> content from a MID cache group, rather than the origin, which is
> shared with multiple EDGEs. EDGE cache groups are configured to have
> one single parent cache group.
>
> <div class="admonition note">
>
> Often the EDGE to MID relationship is based on network distance, and
> does not necessarily match the geographic distance.
>
> </div>
>
> A cache group serves a particular part of the network as defined in
> the coverage zone file. See rl-asn-czf.
>
> Consider the example CDN below:
>
> ![image](cache_groups_1.png)
>
> > align
> >
> > :   center
> >
> There are two MID tier cache groups, each assigned with three EDGEs.
> The lax, den and chi EDGE locations are configured with the West MID
> as their parent, and the nyc, phl, and hou EDGEs, are configured with
> the East MID as their parent. On a cache miss, the EDGEs use their
> assigned parent.

All caches (and other servers) are assigned a Profile in Traffic Ops.

![arrow](fwda.png) Profile
--------------------------

> A Profile is a set of configuration settings and parameters, applied
> to a server or deliveryservice. For a typical cache there are hundreds
> of configuration settings to apply. The Traffic Ops parameter view
> contains the defined settings, and bundled into groups using Profiles.
> Traffic Ops allows for duplication, comparison, import and export of
> Profiles.