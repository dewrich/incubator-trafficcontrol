Traffic Portal - Using
======================

Traffic Portal is the official replacement for the legacy Traffic Ops
UI. Traffic Portal consumes the Traffic Ops API. The following
high-level items are available in the Traffic Portal menu.

![image](./images/tp_menu.png)

> Monitor

-   **Monitor**

      Option                                            Description
      ------------------------------------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      Dashboard                                         A real time view into the main performance indicators of the CDNs managed by Traffic Control. Each component of this view is updated at the intervals defined in tp.domain.com/traffic\_portal\_properties.json. Upon successful login, this is the default landing page of Traffic Portal. See tp-dashboard for details.
      Cache Checks                                      A real time view into the status of each cache. This view is sourced by the Traffic Monitor data thru the Traffic Ops API and is updated on demand. See tp-cache-checks for details.
      Cache Stats                                       A table showing the results of the periodic check extension scripts that are run. See tp-cache-stats for details.

-   **Services**

      -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      Option                                            Description
      ------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------
      Delivery Services                                 Settings for your delivery services. Only the delivery services defined by a user's tenancy are visible. See tp-delivery-services for details.

      Delivery Service Requests                         If enabled in tp.domain.com/traffic\_portal\_properties.json, all delivery service changes (create, update and delete) are captured as a delivery service
                                                        request and must be reviewed before fulfillment/deployment. See tp-delivery-service-requests for details.
      -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-   **Admin**

      Option              Description
      ------------------- --------------------------------------------------------------------------------------
      ASNs                Manage autonomous system numbers (ASN). See tp-asns
      Cache Groups        Manage cache groups. See tp-cache-groups
      CDNs                Manage CDNs. See tp-cdns
      Divisions           Manage divisions. See tp-divisions
      Jobs                Manage invalidate content jobs. See tp-jobs
      Phys Locations      Manage physical locations. See tp-phys-locations
      Parameters          Manage parameters. See tp-parameters
      Profiles            Manage profiles. See tp-profiles
      Regions             Manage regions. See tp-regions
      Servers             Manage servers. See tp-servers
      Statuses            Manage server statuses. See tp-statuses
      Tenants             Manage tenants. See tp-tenants
      Types               Manage types. See tp-types
      Users               Manage users. See tp-users

-   **Tools**

      ------------------------------------------------------------------------
      Option        Description
      ------------- ----------------------------------------------------------
      Generate ISO  Generate a bootable image for any of the servers in the
                    Servers table (or any server for that matter). See
                    tp-gen-iso
      ------------------------------------------------------------------------

-   **Other**

    Custom menu items. By default, you get a link to Traffic Control
    docs. See tp-menu-other

      Option                      Description
      --------------------------- -------------------------------------------------------------------------------------------------------------------
      Docs                        Link to trafficcontrol.apache.org

> Monitor

Monitor
-------

![image](./images/tp_menu_monitor.png)

### Dashboard

The Dashboard is the default landing page for Traffic Portal. It
displays various statistics about the overall health of your CDN.

-   **Current Bandwidth**: The current bandwidth of all of your CDNs.
-   **Current Connections**: The current number of connections to all of
    your CDNs.
-   **Healthy Caches**: Number of healthy caches across all CDNs. Click
    the link to view the healthy caches on the cache stats page.
-   **Unhealthy Caches**: Number of unhealthy caches across all CDNs.
    Click the link to view the unhealthy caches on the cache stats page.
-   **Online Caches**: Number of online caches. Traffic Monitor will not
    monitor the state of ONLINE servers. True health is unknown.
-   **Reported Caches**: Number of caches with REPORTED status.
-   **Offline Caches**: Number of caches with OFFLINE status.
-   **Admin Down Caches**: Number of caches with ADMIN\_DOWN status.

### Cache Checks

The cache checks page is intended to give an overview of the caches
managed by Traffic Control as well as their status.

  ------------------------------------------------------------------------------------------------------------------
  Name            Description
  --------------- --------------------------------------------------------------------------------------------------
  Hostname        Cache host name

  Profile         The name of the profile applied to the cache

  Status          The status of the cache (ONLINE, REPORTED, ADMIN\_DOWN, OFFLINE)

  UPD             Config updates pending for an edge or mid

  RVL             Content invalidation requests are pending for and edge or mid

  ILO             Ping the iLO interface for EDGE or MID servers

  10G             Ping the IPv4 address of the EDGE or MID servers

  FQDN            DNS check that matches what the DNS servers responds with compared to what Traffic Ops has.

  DSCP            Checks the DSCP value of packets from the edge server to the Traffic Ops server.

  10G6            Ping the IPv6 address of the EDGE or MID servers

  MTU             Ping the EDGE or MID using the configured MTU from Traffic Ops

  RTR             Content Router checks. Checks the health of the Content Routers. Checks the health of the caches
                  using the Content Routers.

  CHR             Cache Hit Ratio in percent.

  CDU             Total Cache Disk Usage in percent.

  ORT             Operational Readiness Test. Uses the ORT script on the edge and mid servers to determine if the
                  configuration in Traffic Ops matches the configuration on the edge or mid. The user that this
                  script runs as must have an ssh key on the edge servers.
  ------------------------------------------------------------------------------------------------------------------

### Cache Stats

Displays health by cache group/profile.

  Name          Description
  ------------- --------------------------------------------------------------
  Profile       Name of the profile applied to the edge or mid cache
  Host          ALL or grouped by profile
  Cache Group   Cache Group Name
  Healthy       True/False as determined by Traffic Monitor
  Status        Status of the cache or cache group
  Connections   Number of connections
  MbpsOut       MbpsOut

Services
--------

![image](./images/tp_menu_services.png)

### Delivery Services

A table of your delivery services with the following columns:

+--------+-------------------------------------------------------------+
| Name   | Description                                                 |
+========+=============================================================+
| Key    | A unique string that identifies this delivery service.      |
| (XML   |                                                             |
| ID)    |                                                             |
+--------+-------------------------------------------------------------+
| Tenant | The tenant that the delivery service is assigned to.        |
+--------+-------------------------------------------------------------+
| Origin | The Origin Server's base URL. This includes the protocol    |
|        | (http or https). Example: `http://movies.origin.com`        |
+--------+-------------------------------------------------------------+
| Active | When this is set to false, Traffic Router will not serve    |
|        | DNS or HTTP responses for this delivery service.            |
+--------+-------------------------------------------------------------+
| Type   | The type of content routing this delivery service will use. |
|        | See rl-ds-types.                                            |
+--------+-------------------------------------------------------------+
| Protoc | The protocol to serve this delivery service to the clients  |
| ol     | with:                                                       |
|        |                                                             |
|        | -   HTTP                                                    |
|        | -   HTTPS                                                   |
|        | -   HTTP and HTTPS                                          |
|        | -   HTTP to HTTPS                                           |
+--------+-------------------------------------------------------------+
| CDN    | The CDN that the delivery service belongs to.               |
+--------+-------------------------------------------------------------+
| IPv6   | When set to true, the Traffic Router will respond to AAAA   |
| Enable | DNS requests for the routed name of this delivery service.  |
| d      | Otherwise, only A records will be served.                   |
+--------+-------------------------------------------------------------+
| DSCP   | The DSCP value to mark IP packets to the client with.       |
+--------+-------------------------------------------------------------+
| Signin | See rl-signed-urls.                                         |
| g      |                                                             |
| Algori | -   None                                                    |
| thm    | -   URL Signature Keys                                      |
|        | -   URI Signing Keys                                        |
+--------+-------------------------------------------------------------+
| Query  | How to treat query strings:                                 |
| String |                                                             |
| Handli | -   use in cache key and hand up to origin (each unique     |
| ng     |     query string is treated as a unique URL.)               |
|        | -   do not use in cache key, but pass up to origin (2 URLs  |
|        |     that are the same except for the query string will      |
|        |     match, and cache HIT, while the origin still sees       |
|        |     original query string in the request.)                  |
|        | -   drop at edge (2 URLs that are the same except for the   |
|        |     query string will match, and cache HIT, while the       |
|        |     origin will not see original query string in the        |
|        |     request.)                                               |
|        |                                                             |
|        | **Note:** Choosing to drop query strings at the edge will   |
|        | preclude the use of a Regex Remap Expression. See           |
|        | rl-regex-remap. To set the qstring without the use of regex |
|        | remap, or for further options, see rl-qstring-handling.     |
+--------+-------------------------------------------------------------+
| Last   | Timestamp when the delivery service was last updated.       |
| Update |                                                             |
| d      |                                                             |
+--------+-------------------------------------------------------------+

Delivery service management includes the ability to (where applicable):

-   create a new delivery service
-   clone an existing delivery service
-   update an existing delivery service
-   delete an existing delivery service
-   compare delivery services
-   manage delivery service SSL keys
-   manage delivery service URL signature keys
-   manage delivery service URI signing keys
-   view and assign delivery service servers
-   create, update and delete delivery service regexes
-   view and create delivery service invalidate content jobs
-   manage steering targets

### Delivery Service Requests

A table of your delivery service requests with the following columns:

![image](./images/tp_table_ds_requests.png)

+--------+-------------------------------------------------------------+
| Name   | Description                                                 |
+========+=============================================================+
| Delive | A unique string that identifies the delivery service that   |
| ry     | the request is associated with. This unique string is also  |
| Servic | known as delivery service key or XML ID.                    |
| e      |                                                             |
+--------+-------------------------------------------------------------+
| Type   | The type of delivery service request:                       |
|        |                                                             |
|        | -   create (a request to create a new delivery service)     |
|        | -   update (a request to update an existing delivery        |
|        |     service)                                                |
|        | -   delete (a request to delete an existing delivery        |
|        |     service)                                                |
+--------+-------------------------------------------------------------+
| Status | The status of the delivery service request:                 |
|        |                                                             |
|        | -   draft (the delivery service request is NOT ready for    |
|        |     review and fulfillment)                                 |
|        | -   submitted (the delivery service request is ready for    |
|        |     review and fulfillment)                                 |
|        | -   rejected (the delivery service request has been         |
|        |     rejected and cannot be modified)                        |
|        | -   pending (the delivery service request has been          |
|        |     fulfilled but the changes have yet to be deployed)      |
|        | -   complete (the delivery service request has been         |
|        |     fulfilled and the changes have been deployed)           |
+--------+-------------------------------------------------------------+
| Author | The user responsible for creating the delivery service      |
|        | request.                                                    |
+--------+-------------------------------------------------------------+
| Assign | The user responsible for fulfilling the delivery service    |
| ee     | request. Currently, the operations role or above is         |
|        | required to assign delivery service requests.               |
+--------+-------------------------------------------------------------+
| Last   | The last user to edit the delivery service request.         |
| Edited |                                                             |
| By     |                                                             |
+--------+-------------------------------------------------------------+
| Create | Relative time indicating when the delivery service was      |
| d      | created.                                                    |
+--------+-------------------------------------------------------------+
| Action | Actions that can be performed on a delivery service         |
| s      | request:                                                    |
|        |                                                             |
|        | -   fulfill (Implement the changes captured in the delivery |
|        |     service request. Currently limited to users with the    |
|        |     operations role or above.)                              |
|        | -   reject (Reject the changes captured in the delivery     |
|        |     service request. Currently limited to users with the    |
|        |     operations role or above.)                              |
|        | -   delete (Delete the delivery service request. Currently  |
|        |     limited to users with the portal role or above.)        |
+--------+-------------------------------------------------------------+

Delivery service request management includes the ability to (where
applicable):

-   create a new delivery service request
-   update an existing delivery service request
-   delete an existing delivery service request
-   update the status of a delivery service request
-   assign a delivery service request
-   reject a delivery service request
-   fulfill a delivery service request

See ds\_requests for details.

Admin
-----

![image](./images/tp_menu_admin.png)

### ASNs

A table of ASNs with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  ASN           
  Cache Group   

ASN management includes the ability to (where applicable):

-   create a new ASN
-   update an existing ASN
-   delete an existing ASN

### Cache Groups

A table of cache groups with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Short Name    
  Type          
  Latitude      
  Longitude     

Cache group management includes the ability to (where applicable):

-   create a new cache group
-   update an existing cache group
-   delete an existing cache group
-   queue/clear updates for all servers in a cache group
-   view cache group ASNs
-   view and assign cache group parameters
-   view cache group servers

### CDNs

A table of CDNs with the following columns:

  ----------------------------------------------------------------------------------------------------
  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          

  Domain        

  DNSSEC        
  Enabled       
  ----------------------------------------------------------------------------------------------------

CDN management includes the ability to (where applicable):

-   create a new CDN
-   update an existing CDN
-   delete an existing CDN
-   queue/clear updates on all servers in a CDN
-   diff CDN snapshot
-   create CDN snapshot
-   manage CDN DNSSEC keys
-   manage CDN federations
-   view CDN delivery services
-   view CDN profiles
-   view CDN servers

### Divisions

A table of divisions with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          

Division management includes the ability to (where applicable):

-   create a new division
-   update an existing division
-   delete an existing division
-   view division regions

### Jobs

A table of invalidate content jobs with the following columns:

  ----------------------------------------------------------------------------------------------------
  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Delivery      
  Service       

  Asset URL     

  Parameters    

  Start         

  Created By    
  ----------------------------------------------------------------------------------------------------

Job management includes the ability to (where applicable):

-   create a new invalidate content job

### Phys Locations

A table of physical locations with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Short Name    
  Address       
  City          
  State         
  Region        

Physical location management includes the ability to (where applicable):

-   create a new physical location
-   update an existing physical location
-   delete an existing physical location
-   view physical location servers

### Parameters

A table of parameters with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Config File   
  Value         

Parameter management includes the ability to (where applicable):

-   create a new parameter
-   update an existing parameter
-   delete an existing parameter
-   view parameter profiles

### Profiles

A table of profiles with the following columns:

  ----------------------------------------------------------------------------------------------------
  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          

  Type          

  Routing       
  Disabled      

  Description   

  CDN           
  ----------------------------------------------------------------------------------------------------

Profile management includes the ability to (where applicable):

-   create a new profile
-   update an existing profile
-   delete an existing profile
-   clone a profile
-   export a profile
-   view profile parameters
-   view profile delivery services
-   view profile servers

See rl-working-with-profiles for details.

### Regions

A table of regions with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Division      

Region management includes the ability to (where applicable):

-   create a new region
-   update an existing region
-   delete an existing region
-   view region physical locations

### Servers

A table of servers with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  UPD           
  Host          
  Domain        
  IP            
  IPv6          
  Status        
  Type          
  Profile       
  CDN           
  Cache Group   
  ISO           

Server management includes the ability to (where applicable):

-   create a new server
-   update an existing server
-   delete an existing server
-   queue/clear updates on a server
-   update server status
-   view server delivery services
-   view server config files
-   clone delivery service assignments
-   assign delivery services to server

### Statuses

A table of statuses with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Description   

Status management includes the ability to (where applicable):

-   create a new status
-   update an existing status
-   delete an existing status
-   view status servers

### Tenants

A table of tenants with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Active        
  Parent        

Tenant management includes the ability to (where applicable):

-   create a new tenant
-   update an existing tenant
-   delete an existing tenant
-   view users assigned to a tenant
-   view delivery services assigned to a tenant

### Types

A table of types with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Name          
  Use In Table  
  Description   

Type management includes the ability to (where applicable):

-   create a new type
-   update an existing type
-   delete an existing type
-   view delivery services assigned to a type
-   view servers assigned to a type
-   view cache groups assigned to a type

### Users

A table of users with the following columns:

  Name          Description
  ------------- --------------------------------------------------------------------------------------
  Full Name     
  Username      
  Email         
  Tenant        
  Role          

User management includes the ability to (where applicable):

-   register a new user
-   create a new user
-   update an existing user
-   view delivery services visible to a user

Tools
-----

![image](./images/tp_menu_tools.png)

### Generate ISO

See rl-generate-iso

Other
-----

![image](./images/tp_menu_other.png)

### Custom Menu Items

This section is configurable in
tp.domain.com/traffic\_portal\_properties.json in the customMenu
section.
