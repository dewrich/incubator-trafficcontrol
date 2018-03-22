Traffic Ops - Configuring
=========================

Follow the steps below to configure the newly installed Traffic Ops
Instance.

Installing the SSL Cert
-----------------------

By default, Traffic Ops runs as an SSL web server, and a certificate
needs to be installed.

### Self-signed Certificate (Development)

> Example Procedure:
>
>     $ openssl genrsa -des3 -passout pass:x -out localhost.pass.key 2048
>     Generating RSA private key, 2048 bit long modulus
>     ...
>     $ openssl rsa -passin pass:x -in localhost.pass.key -out localhost.key
>     writing RSA key
>     $ rm localhost.pass.key
>
>     $ openssl req -new -key localhost.key -out localhost.csr
>     You are about to be asked to enter information that will be incorporated
>     into your certificate request.
>     What you are about to enter is what is called a Distinguished Name or a DN.
>     There are quite a few fields but you can leave some blank
>     For some fields there will be a default value,
>     If you enter '.', the field will be left blank.
>     -----
>     Country Name (2 letter code) [XX]:US<enter>
>     State or Province Name (full name) []:CO<enter>
>     Locality Name (eg, city) [Default City]:Denver<enter>
>     Organization Name (eg, company) [Default Company Ltd]: <enter>
>     Organizational Unit Name (eg, section) []: <enter>
>     Common Name (eg, your name or your server's hostname) []: <enter>
>     Email Address []: <enter>
>
>     Please enter the following 'extra' attributes
>     to be sent with your certificate request
>     A challenge password []: pass<enter>
>     An optional company name []: <enter>
>     $ openssl x509 -req -sha256 -days 365 -in localhost.csr -signkey localhost.key -out localhost.crt
>     Signature ok
>     subject=/C=US/ST=CO/L=Denver/O=Default Company Ltd
>     Getting Private key
>     $ sudo cp localhost.crt /etc/pki/tls/certs
>     $ sudo cp localhost.key /etc/pki/tls/private
>     $ sudo chown trafops:trafops /etc/pki/tls/certs/localhost.crt
>     $ sudo chown trafops:trafops /etc/pki/tls/private/localhost.key

### Certificate from Certificate Authority (Production)

<div class="admonition note">

You will need to know the appropriate answers when generating the
certificate request file trafficopss.csr below.

</div>

Example Procedure:

    $ openssl genrsa -des3 -passout pass:x -out trafficops.pass.key 2048
    Generating RSA private key, 2048 bit long modulus
    ...
    $ openssl rsa -passin pass:x -in trafficops.pass.key -out trafficops.key
    writing RSA key
    $ rm localhost.pass.key

    Generate the Certificate Signing Request (CSR) file needed for Certificate Authority (CA) request.

    $ openssl req -new -key trafficops.key -out trafficops.csr
    You are about to be asked to enter information that will be incorporated
    into your certificate request.
    What you are about to enter is what is called a Distinguished Name or a DN.
    There are quite a few fields but you can leave some blank
    For some fields there will be a default value,
    If you enter '.', the field will be left blank.
    -----
    Country Name (2 letter code) [XX]: <enter country code>
    State or Province Name (full name) []: <enter state or province>
    Locality Name (eg, city) [Default City]: <enter locality name>
    Organization Name (eg, company) [Default Company Ltd]: <enter organization name>
    Organizational Unit Name (eg, section) []: <enter organizational unit name>
    Common Name (eg, your name or your server's hostname) []: <enter server's hostname name>
    Email Address []: <enter e-mail address>

    Please enter the following 'extra' attributes
    to be sent with your certificate request
    A challenge password []: <enter challenge password>
    An optional company name []: <enter>
    $ sudo cp trafficops.key /etc/pki/tls/private
    $ sudo chown trafops:trafops /etc/pki/tls/private/trafficops.key

    You must then take the output file trafficops.csr and submit a request to your Certificate Authority (CA).
    Once you get approved and receive your trafficops.crt file:

    $ sudo cp trafficops.crt /etc/pki/tls/certs
    $ sudo chown trafops:trafops /etc/pki/tls/certs/trafficops.crt

    If necessary, install the CA certificates .pem and .crt in /etc/pki/tls/certs.

    You will need to update the file /opt/traffic_ops/app/conf/cdn.conf with the following changes:
          ...
          e.g. given trafficops.crt and trafficops.key
          'hypnotoad' => ...
              'listen' => 'https://[::]:443?cert=/etc/pki/tls/certs/trafficops.crt&key=/etc/pki/tls/private/trafficops.key&ca=/etc/pki/tls/certs/localhost.ca&verify=0x00&ciphers=AES128-GCM-SHA256:HIGH:!RC4:!MD5:!aNULL:!EDH:!ED'
           ...

Content Delivery Networks
-------------------------

Profile Parameters
------------------

Many of the settings for the different servers in a Traffic Control CDN
are controlled by parameters in the parameter view of Traffic Ops.
Parameters are grouped in profiles and profiles are assigned to a server
or a deliveryservice. For a typical cache there are hundreds of
configuration settings to apply. The Traffic Ops parameter view contains
the defined settings. To make life easier, Traffic Ops allows for
duplication, comparison, import and export of Profiles. Traffic Ops also
has a "Global profile" - the parameters in this profile are going to be
applied to all servers in the Traffic Ops instance, or apply to Traffic
Ops themselves. These parameters are:

> Global Profile

  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Name                                                                          Config file                                    Value
  ----------------------------------------------------------------------------- ---------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  tm.url                                                                        global                                         The URL where this Traffic Ops instance is being served from.

  tm.rev\_proxy.url                                                             global                                         Not required. The URL where the Traffic Ops Config file cache instance is being served from. Requires Traffic Ops ORT 2.1 and above. When configured, ORT will request configuration files via this fqdn, which should be setup as a reverse proxy to the Traffic Ops host or hosts. Suggested cache lifetime for these files is \~3 minutes or less. This setting allows for greater scaleability of
                                                                                                                               a CDN maintained by Traffic Ops by caching configuration files of profile and cdn scope.

  tm.toolname                                                                   global                                         The name of the Traffic Ops tool. Usually "Traffic Ops". Used in the About screen and in the comments headers of the files generated.

  tm.infourl                                                                    global                                         This is the "for more information go here" URL, which is visible in the About page.

  tm.logourl                                                                    global                                         This is the URL of the logo for Traffic Ops and can be relative if the logo is under traffic\_ops/app/public.

  tm.instance\_name                                                             global                                         The name of the Traffic Ops instance. Can be used when multiple instances are active. Visible in the About page.

  tm.traffic\_mon\_fwd\_proxy                                                   global                                         When collecting stats from Traffic Monitor, Traffic Ops uses this forward proxy to pull the stats through. This can be any of the MID tier caches, or a forward cache specifically deployed for this purpose. Setting this variable can significantly lighten the load on the Traffic Monitor system and it is recommended to set this parameter on a production system.

  geolocation.polling.url                                                       CRConfig.json                                  The location to get the GeoLiteCity database from.

  geolocation6.polling.url                                                      CRConfig.json                                  The location to get the IPv6 GeoLiteCity database from.

  maxmind.default.override                                                      CRConfig.json                                  The destination geo coordinates to use for client location when maxmind returns a default location that matches the country code. This parameter can be specified multiple times with different values to support default overrides for multiple countries. Format: &lt;CountryCode&gt;;&lt;Lat&gt;,&lt;Long&gt; Ex: US;37.751,-97.822
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

These parameters should be set to reflect the local environment.

After running the postinstall script, Traffic Ops has the following
profiles pre-loaded:

  Name          Description
  ------------- -------------------------------------------------------------------------------------------------------------------
  EDGE1         The profile to be applied to the latest supported version of ATS, when running as an EDGE cache
  TR1           The profile to be applied to the latest version of Traffic Router
  TM1           The profile to be applied to the latest version of Traffic Monitor
  MID1          The profile to be applied to the latest supported version of ATS, when running as an MID cache
  RIAK\_ALL     Riak profile for all CDNs to be applied to the Traffic Vault servers

<div class="admonition note">

The Traffic Server profiles contain some information that is specific to
the hardware being used (most notably the disk configuration), so some
parameters will have to be changed to reflect your configuration. Future
releases of Traffic Control will separate the hardware and software
profiles so it is easier to "mix-and-match" different hardware
configurations.

</div>

Below is a list of cache parameters that are likely to need changes from
the default profiles shipped with Traffic Ops:

  Name                                                                        Config file                                              Description
  --------------------------------------------------------------------------- -------------------------------------------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  allow\_ip                                                                   astats.config                                            This is a comma separated list of IPv4 CIDR blocks that will have access to the astats statistics on the caches. The Traffic Monitor IP addresses have to be included in this, if they are using IPv4 to monitor the caches.
  allow\_ip6                                                                  astats.config                                            This is a comma separated list of IPv6 CIDR blocks that will have access to the astats statistics on the caches. The Traffic Monitor IP addresses have to be included in this, if they are using IPv6 to monitor the caches.
  Drive\_Prefix                                                               storage.config                                           The device path start of the disks. For example, if you have `/dev/sda` through `/dev/sdf` set this to `/dev/sd`
  Drive\_Letters                                                              storage.config                                           The letter part of the disks, in the same example as above set this to `a,b,c,d,e,f`
  purge\_allow\_ip                                                            ip\_allow.config                                         The IP address range that is allowed to execute the PURGE method on the caches (not related to rl-purge)
  coalesce\_masklen\_v4                                                       ip\_allow.config                                         The masklen to use when coalescing v4 networks into one line using <http://search.cpan.org/~miker/NetAddr-IP-4.078/IP.pm>
  coalesce\_number\_v4                                                        ip\_allow.config                                         The number to use when coalescing v4 networks into one line using <http://search.cpan.org/~miker/NetAddr-IP-4.078/IP.pm>
  coalesce\_masklen\_v6                                                       ip\_allow.config                                         The masklen to use when coalescing v6 networks into one line using <http://search.cpan.org/~miker/NetAddr-IP-4.078/IP.pm>
  coalesce\_masklen\_v6                                                       ip\_allow.config                                         The masklen to use when coalescing v6 networks into one line using <http://search.cpan.org/~miker/NetAddr-IP-4.078/IP.pm>
  health.threshold.loadavg                                                    rascal.properties                                        The Unix load average at which Traffic Router will stop sending traffic to this cache
  health.threshold.\\ availableBandwidthInKbps                                rascal.properties                                        The amount of bandwidth that Traffic Router will try to keep available on the cache. For example: ""&gt;1500000" means stop sending new traffic to this cache when traffic is at 8.5Gbps on a 10Gbps interface.

Below is a list of Traffic Server plugins that need to be configured in
the parameter table:

  Name                                                                                                                            Config file                                                                                                 Description                                                                                                                                                                                                                                                                                                                                                                     Details
  ------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  astats\_over\_http                                                                                                              package                                                                                                     The package version for the astats\_over\_http plugin.                                                                                                                                                                                                                                                                                                                          [astats\_over\_http](http://trafficcontrol.apache.org/downloads/index.html)
  trafficserver                                                                                                                   package                                                                                                     The package version for the trafficserver plugin.                                                                                                                                                                                                                                                                                                                               [trafficserver](http://trafficcontrol.apache.org/downloads/index.html)
  regex\_revalidate                                                                                                               plugin.config                                                                                               The config to be used for regex\_revalidate. For example: --config regex\_revalidate.config                                                                                                                                                                                                                                                                                     [regex\_revalidate](https://docs.trafficserver.apache.org/en/5.3.x/reference/plugins/regex_remap.en.html)
  remap\_stats                                                                                                                    plugin.config                                                                                               The config to be used for remap\_stats. Value is left blank.                                                                                                                                                                                                                                                                                                                    [remap\_stats](https://github.com/apache/trafficserver/tree/master/plugins/experimental/remap_stats)

Below is a list of cache parameters for special configuration, which are
unlikely to need changes, but may be useful in particular circumstances:

  ------------------------------------------------------------------------------------------------------------------------------------------------
  Name                   Config file       Description
  ---------------------- ----------------- -------------------------------------------------------------------------------------------------------
  not\_a\_parent         parent.config     This is a boolean flag and is considered true if it exists and has any value except 'false'. This
                                           prevents servers with this parameter in their profile from being inserted into the parent.config
                                           generated for servers with this server's cachegroup as a parent of their cachegroup. This is primarily
                                           useful for when edge caches are configured to have a cachegroup of other edge caches as parents (a
                                           highly unusual configuration), and it is necessary to exclude some, but not all, edges in the parent
                                           cachegroup from the parent.config (for example, because they lack necessary capabilities), but still
                                           have all edges in the same cachegroup in order to take traffic from ordinary delivery services at that
                                           cachegroup's geo location. Once again, this is a highly unusual scenario, and under ordinary
                                           circumstances this parameter should not exist.
  ------------------------------------------------------------------------------------------------------------------------------------------------

Regions, Locations and Cache Groups
-----------------------------------

All servers have to have a location, which is their physical location.
Each location is part of a region, and each region is part of a
division. For Example, `Denver` could be a location in the `Mile High`
region and that region could be part of the `West` division. Enter your
divisions first in Misc-&gt;Divisions, then enter the regions in
Misc-&gt;Regions, referencing the divisions entered, and finally, enter
the physical locations in Misc-&gt;Locations, referencing the regions
entered.

All servers also have to be part of a cache group. A cache group is a
logical grouping of caches, that don't have to be in the same physical
location (in fact, usually a cache group is spread across minimally 2
physical Locations for redundancy purposes), but share geo coordinates
for content routing purposes. JvD to add more.

Configuring Content Purge
-------------------------

Content purge using ATS is not simple; there is no file system to delete
files/directories from, and in large caches it can be hard to delete a
simple regular expression from the cache. This is why Traffic Control
uses the [Regex Revalidate
Plugin](https://docs.trafficserver.apache.org/en/latest/admin-guide/plugins/regex_revalidate.en.html)
to purge content from the system. We don't actually remove the content,
we have a check that gets run before each request on each cache to see
if this request matches a list of regular expressions, and if it does,
we force a revalidation to the origin, making the original content
inaccessible. The regex\_revalidate plugin will monitor it's config
file, and will pick up changes to it without a traffic\_line -x signal
to ATS. Changes to this file need to be distributed to the highest tier
(MID) caches in the CDN before they are distributed to the lower tiers,
to prevent filling the lower tiers with the content that should be
purged from the higher tiers without hitting the origin. This is why the
ort script (see reference-traffic-ops-ort) will by default push out
config changes to MID first, confirm that they have all been updated,
and then push out the changes to the lower tiers. In large CDNs, this
can make the distribution and time to activation of the purge too long,
and because of that there is the option to not distribute the
regex\_revalidate.config file using the ort script, but to do this using
other means. By default, Traffic Ops will use ort to distribute the
regex\_revalidate.config file.

Content Purge is controlled by the following parameters in the profile
of the cache:

  Name                                                                                                        Config file                                                                                                              Description                                                                                                                                                                                                                                   Details
  ----------------------------------------------------------------------------------------------------------- ------------------------------------------------------------------------------------------------------------------------ --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  location                                                                                                    regex\_revalidate.config                                                                                                 What location the file should be in on the cache                                                                                                                                                                                              The presence of this parameter tells ort to distribute this file; delete this parameter from the profile if this file is distributed using other means.
  maxRevalDurationDays                                                                                        regex\_revalidate.config                                                                                                 The maximum time a purge can be active                                                                                                                                                                                                        To prevent a build up of many checks before each request, this is longest time the system will allow
  regex\_revalidate                                                                                           plugin.config                                                                                                            The config to be used for regex\_revalidate. For example: --config regex\_revalidate.config                                                                                                                                                   [regex\_revalidate](https://docs.trafficserver.apache.org/en/5.3.x/reference/plugins/regex_remap.en.html)
  use\_reval\_pending                                                                                         global                                                                                                                   Configures Traffic Ops to use separate reval\_pending flag for each cache.                                                                                                                                                                    When this flag is in use ORT will check for a new regex\_revalidate.config every 60 seconds in syncds mode during the dispersal timer. This will also allow ORT to be run in revalidate mode, which will check for and clear the reval\_pending flag. This can be set to run via cron task. Enable with a value of 1. Use of this feature requires Traffic Ops 2.1 and above. Parameter should be assigned to the GLOBAL profile.

Note that the TTL the adminstrator enters in the purge request should be
longer than the TTL of the content to ensure the bad content will not be
used. If the CDN is serving content of unknown, or unlimited TTL, the
administrator should consider using
[proxy-config-http-cache-guaranteed-min-lifetime](https://docs.trafficserver.apache.org/en/latest/admin-guide/files/records.config.en.html#proxy-config-http-cache-guaranteed-min-lifetime)
to limit the maximum time an object can be in the cache before it is
considered stale, and set that to the same value as maxRevalDurationDays
(Note that the former is in seconds and the latter is in days, so
convert appropriately).

### Creating the CentOS Kickstart File

The kickstart file is a text file, containing a list of items, each
identified by a keyword. You can create it by using the Kickstart
Configurator application, or writing it from scratch. The Red Hat
Enterprise Linux installation program also creates a sample kickstart
file based on the options that you selected during installation. It is
written to the file `/root/anaconda-ks.cfg`. This file is editable using
most text editors that can save files as ASCII text.

To generate ISO, the CentOS Kickstart is necessary:

1.  Create a kickstart file.
2.  Create a boot media with the kickstart file or make the kickstart
    file available on the network.
3.  Make the installation tree available.
4.  Start the kickstart installation.

Create a ks.src file in the root of the selection location. See the
example below:

:

    mkdir newdir
    cd newdir/
    cp -r ../centos65/* .
    vim ks.src
    vim isolinux/isolinux.cfg
    cd vim osversions.cfg
    vim osversions.cfg

This is a standard kickstart formatted file that the generate ISO
process uses to create the kickstart (ks.cfg) file for the install. The
generate ISO process uses the ks.src, overwriting any information set in
the Generate ISO tab in Traffic Ops, creating ks.cfg.

<div class="admonition note">

Streamline your install folder for under 1GB, which assists in creating
a CD.

</div>

Configuring the Go Application
------------------------------

Traffic Ops is in the process of migrating from Perl to Go, and
currently runs as two applications. The Go application serves all
endpoints which have been rewritten in the Go language, and
transparently proxies all other requests to the old Perl application.
Both applications are installed by the RPM, and both run as a single
service. When the project has fully migrated to Go, the Perl application
will be removed, and the RPM and service will consist solely of the Go
application.

By default, the postinstall script configures the Go application to
behave and transparently serve as the old Perl Traffic Ops did in
previous versions. This includes reading the old `cdn.conf` and
`database.conf` config files, and logging to the old `access.log`
location. However, if you wish to customize the Go Traffic Ops
application, you can do so by running it with the `-oldcfg=false`
argument. By default, it will then look for a config file in
`/opt/traffic_ops/conf/traffic_ops_golang.config`. The new config file
location may also be customized via the `-cfg` flag. A sample config
file is installed by the RPM at
`/opt/traffic_ops/conf/traffic_ops_golang.config`. If you wish to run
the new Go Traffic Ops application as a service with a new config file,
the `-oldcfg=false` and `-cfg` flags may be added to the `start`
function in the service file, located by default at
`etc/init.d/traffic_ops`.
