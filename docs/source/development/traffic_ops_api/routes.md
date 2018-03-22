<style>
table {
    table-layout: fixed;
    width: 100%;
}

td {
    word-wrap:break-word;
}
table.docutils col:nth-child(1) {
    width: 30%;
}
table.docutils col:nth-child(2) {
    width: 30%;
}
table.docutils col:nth-child(3) {
    width: 30%;
}
.wy-nav-content {
    max-width: 1200px;
    width: 90%;
}
</style>
API Routes
==========

+-----------------+-------------------------+-------------------------+
| 1.0             | 1.1                     | 1.2                     |
+=================+=========================+=========================+
| /asns           | > to-api-v11-asns-route | > to-api-v12-asns-route |
+-----------------+-------------------------+-------------------------+
| /availableds    | > to-api-v11-ds-route   | > to-api-v12-ds-route   |
+-----------------+-------------------------+-------------------------+
| *Not            | > *Not Implemented*     | > to-api-v12-cache-stat |
| Implemented*    |                         | s-route                 |
+-----------------+-------------------------+-------------------------+
| /datacrans      | > /api/1.1/crans.json   | > /api/1.2/crans.json   |
+-----------------+-------------------------+-------------------------+
| /datacrans/orde | > /api/1.1/crans.json   | > /api/1.2/crans.json   |
| rby/:field      |                         |                         |
+-----------------+-------------------------+-------------------------+
| /datadeliveryse | > to-api-v11-ds-route   | > to-api-v12-ds-route   |
| rvice           |                         |                         |
+-----------------+-------------------------+-------------------------+
| /datadeliveryse | > /api/1.1/deliveryserv | > /api/1.2/deliveryserv |
| rviceserver     | iceserver.json          | iceserver.json          |
+-----------------+-------------------------+-------------------------+
| /datadomains    | > /api/1.1/cdns/domains | > /api/1.2/cdns/domains |
|                 | .json                   | .json                   |
+-----------------+-------------------------+-------------------------+
| *Not            | > *Not Implemented*     | > to-api-v12-ds-stats-r |
| Implemented*    |                         | oute                    |
+-----------------+-------------------------+-------------------------+
| /datahwinfo     | > to-api-v11-hwinfo-rou | > to-api-v12-hwinfo-rou |
|                 | te                      | te                      |
+-----------------+-------------------------+-------------------------+
| /datalinks      | > /api/1.1/deliveryserv | > /api/1.2/deliveryserv |
|                 | iceserver.json          | iceserver.json          |
+-----------------+-------------------------+-------------------------+
| /datalinks/orde | > /api/1.1/deliveryserv | > /api/1.2/deliveryserv |
| rby/:field      | iceserver.json          | iceserver.json          |
+-----------------+-------------------------+-------------------------+
| /datalogs       | > to-api-v11-change-log | > to-api-v12-change-log |
|                 | s-route                 | s-route                 |
+-----------------+-------------------------+-------------------------+
| /datalocation/o | > to-api-v11-cachegroup | > to-api-v12-cachegroup |
| rderby/id       | s-route                 | s-route                 |
+-----------------+-------------------------+-------------------------+
| /datalocationpa | > to-api-v11-cachegroup | > to-api-v12-cachegroup |
| rameters        | s-route                 | s-route                 |
+-----------------+-------------------------+-------------------------+
| /dataparameter  | > to-api-v11-parameters | > to-api-v12-parameters |
|                 | -route                  | -route                  |
+-----------------+-------------------------+-------------------------+
| /dataparameter/ | > /api/1.1/parameters/p | > /api/1.2/parameters/p |
| :parameter      | rofile/:parameter.json  | rofile/:parameter.json  |
+-----------------+-------------------------+-------------------------+
| /dataphys\_loca | > to-api-v11-phys-loc-r | > to-api-v12-phys-loc-r |
| tion            | oute                    | oute                    |
+-----------------+-------------------------+-------------------------+
| /dataprofile    | > to-api-v11-profiles-r | > to-api-v12-profiles-r |
|                 | oute                    | oute                    |
| /dataprofile/or |                         |                         |
| derby/name      |                         |                         |
+-----------------+-------------------------+-------------------------+
| /dataregion     | > to-api-v11-regions-ro | > to-api-v12-regions-ro |
|                 | ute                     | ute                     |
+-----------------+-------------------------+-------------------------+
| /datarole       | > to-api-v11-roles-rout | > to-api-v12-roles-rout |
|                 | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| /datarole/order | > to-api-v11-roles-rout | > to-api-v12-roles-rout |
| by/:field       | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| /dataserver     | > to-api-v11-servers-ro | > to-api-v12-servers-ro |
|                 | ute                     | ute                     |
+-----------------+-------------------------+-------------------------+
| /dataserver/ord | > to-api-v11-servers-ro | > to-api-v12-servers-ro |
| erby/:field     | ute                     | ute                     |
+-----------------+-------------------------+-------------------------+
| /dataserverdeta | > /api/1.1/servers/host | > /api/1.2/servers/host |
| il/select/:host | name/:hostname/details. | name/:hostname/details. |
| name            | json                    | json                    |
+-----------------+-------------------------+-------------------------+
| /datastaticdnse | > to-api-v11-static-dns | > to-api-v12-static-dns |
| ntry            | -route                  | -route                  |
+-----------------+-------------------------+-------------------------+
| /datastatus     | > to-api-v11-statuses-r | > to-api-v12-statuses-r |
|                 | oute                    | oute                    |
+-----------------+-------------------------+-------------------------+
| /datastatus/ord | > to-api-v11-statuses-r | > to-api-v12-statuses-r |
| erby/name       | oute                    | oute                    |
+-----------------+-------------------------+-------------------------+
| /datatype       | > to-api-v11-types-rout | > to-api-v12-types-rout |
|                 | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| /datatype/order | > to-api-v11-types-rout | > to-api-v12-types-rout |
| by/:field       | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| /datauser       | > to-api-v11-users-rout | > to-api-v12-users-rout |
|                 | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| /datauser/order | > to-api-v11-users-rout | > to-api-v12-users-rout |
| by/:field       | e                       | e                       |
+-----------------+-------------------------+-------------------------+
| *Not            | > *Not Implemented*     | > to-api-v12-configfile |
| Implemented*    |                         | s\_ats-route            |
+-----------------+-------------------------+-------------------------+


