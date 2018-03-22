Traffic Portal Administration
=============================

The following are requirements to ensure an accurate set up:

-   CentOS 6.7 or 7
-   Node.js 6.0.x or above

**Installing Traffic Portal**

> -   Download the Traffic Portal RPM from [Apache
>     Jenkins](https://builds.apache.org/view/S-Z/view/TrafficControl/job/incubator-trafficcontrol-master-build/)
>     or build the Traffic Portal RPM from source (./pkg -v
>     traffic\_portal\_build).
> -   Copy the Traffic Portal RPM to your server
> -   curl --silent --location <https://rpm.nodesource.com/setup_6.x> |
>     sudo bash -
> -   sudo yum install -y nodejs
> -   sudo yum install -y &lt;traffic\_portal rpm&gt;

**Configuring Traffic Portal**

> -   update /etc/traffic\_portal/conf/config.js (if upgrade, reconcile
>     config.js with config.js.rpmnew and then delete config.js.rpmnew)
> -   update
>     /opt/traffic\_portal/public/traffic\_portal\_properties.json (if
>     upgrade, reconcile traffic\_portal\_properties.json with
>     traffic\_portal\_properties.json.rpmnew and then delete
>     traffic\_portal\_properties.json.rpmnew)
> -   \[OPTIONAL\] update
>     /opt/traffic\_portal/public/resources/assets/css/custom.css (to
>     customize traffic portal skin)

**Starting Traffic Portal**

> -   sudo service traffic\_portal start

**Stopping Traffic Portal**

> -   sudo service traffic\_portal stop

