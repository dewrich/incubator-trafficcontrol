Traffic Monitor APIs
====================

The Traffic Monitor URLs below allow certain query parameters for use in
controlling the data returned. The optional query parameters are the
*tabbed* in values under each URL, if they exist.

| 

**/publish/EventLog**

Log of recent events.

| 

**/publish/CacheStats**

Statistics gathered for each cache.

**Query Parameters**

  -------------------------------------------------------------------------------------------------
  Parameter           Type          Description
  ------------------- ------------- ---------------------------------------------------------------
  `hc`                int           The history count, number of items to display.

  `stats`             string        A comma separated list of stats to display.

  `wildcard`          boolean       Controls whether specified stats should be treated as partial
                                    strings.
  -------------------------------------------------------------------------------------------------

| 

**/publish/CacheStats/:cache**

Statistics gathered for only this cache.

**Query Parameters**

  -------------------------------------------------------------------------------------------------
  Parameter           Type          Description
  ------------------- ------------- ---------------------------------------------------------------
  `hc`                int           The history count, number of items to display.

  `stats`             string        A comma separated list of stats to display.

  `wildcard`          boolean       Controls whether specified stats should be treated as partial
                                    strings.
  -------------------------------------------------------------------------------------------------

| 

**/publish/DsStats**

Statistics gathered for delivery services.

**Query Parameters**

  -------------------------------------------------------------------------------------------------
  Parameter           Type          Description
  ------------------- ------------- ---------------------------------------------------------------
  `hc`                int           The history count, number of items to display.

  `stats`             string        A comma separated list of stats to display.

  `wildcard`          boolean       Controls whether specified stats should be treated as partial
                                    strings.
  -------------------------------------------------------------------------------------------------

| 

**/publish/DsStats/:deliveryService**

Statistics gathered for this delivery service only.

**Query Parameters**

  -------------------------------------------------------------------------------------------------
  Parameter           Type          Description
  ------------------- ------------- ---------------------------------------------------------------
  `hc`                int           The history count, number of items to display.

  `stats`             string        A comma separated list of stats to display.

  `wildcard`          boolean       Controls whether specified stats should be treated as partial
                                    strings.
  -------------------------------------------------------------------------------------------------

| 

**/publish/CrStates**

The current state of this CDN per the health protocol.

| 

**raw**

The current state of this CDN per this Traffic Monitor only.

| 

**/publish/CrConfig**

The CrConfig served to and consumed by Traffic Router.

| 

**/publish/PeerStates**

The health state information from all peer Traffic Monitors.

**Query Parameters**

  -------------------------------------------------------------------------------------------------
  Parameter           Type          Description
  ------------------- ------------- ---------------------------------------------------------------
  `hc`                int           The history count, number of items to display.

  `stats`             string        A comma separated list of stats to display.

  `wildcard`          boolean       Controls whether specified stats should be treated as partial
                                    strings.
  -------------------------------------------------------------------------------------------------

| 

**/publish/Stats**

The general statistics about Traffic Monitor.

| 

**/publish/StatSummary**

The summary of cache statistics.

**Query Parameters**

  Parameter              Type           Description
  ---------------------- -------------- ------------------------------------------------------------------------------------
  `startTime`            number         Window start. The number of milliseconds since the epoch.
  `endTime`              number         Window end. The number of milliseconds since the epoch.
  `hc`                   int            The history count, number of items to display.
  `stats`                string         A comma separated list of stats to display.
  `wildcard`             boolean        Controls whether specified stats should be treated as partial strings.
  `cache`                string         Summary statistics for just this cache.

| 

**/publish/ConfigDoc**

The overview of configuration options.
