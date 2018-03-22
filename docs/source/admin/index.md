Administrator's Guide
=====================

Traffic Control is distributed in source form for the developer, but
also as a binary package. This guide details how to install and
configure a Traffic Control CDN using the binary packages, as well as
how to perform common operations running a CDN.

When installing a complete CDN from scratch, a sample recommended order
is:

1.  Traffic Ops
2.  Traffic Vault (Riak)
3.  Traffic Monitor
4.  Apache Traffic Server Mid-Tier Caches
5.  Apache Traffic Server Edge Caches
6.  Traffic Router
7.  Traffic Stats
8.  Traffic Portal

Once everything is installed, you will need to configure the servers to
talk to each other. You will also need Origin server(s), which the
Mid-Tier Cache(s) get content from. An Origin server is simply an
HTTP(S) server which serves the content you wish to cache on the CDN.

> maxdepth
>
> :   3
>
> traffic\_ops/installation.rst traffic\_ops/default\_profiles.rst
> traffic\_ops/migration\_from\_10\_to\_20.rst
> traffic\_ops/migration\_from\_20\_to\_22.rst
> traffic\_ops/configuration.rst traffic\_ops/using.rst
> traffic\_ops/extensions.rst traffic\_portal/installation.rst
> traffic\_portal/usingtrafficportal.rst traffic\_monitor.rst
> traffic\_monitor\_golang.rst traffic\_router.rst traffic\_stats.rst
> traffic\_server.rst traffic\_vault.rst quick\_howto/index.rst
