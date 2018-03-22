Traffic Portal
==============

Introduction
------------

Traffic Portal is an [AngularJS 1.x](https://angularjs.org/) client
served from a [Node.js](https://nodejs.org/en/) web server designed to
consume the Traffic Ops 1.x API. The Traffic Portal replaces the Traffic
Ops UI.

Software Requirements
---------------------

To work on Traffic Portal you need a \*nix (MacOS and Linux are most
commonly used) environment that has the following installed:

> -   [Ruby Devel 2.0.x or
>     above](https://www.rpmfind.net/linux/rpm2html/search.php?query=ruby-devel)
> -   [Compass 1.0.x or above](http://compass-style.org/)
> -   [Node.js 6.0.x or above](https://nodejs.org/en/)
> -   [Bower 1.7.9 or above](https://nodejs.org/en/)
> -   [Grunt CLI 1.2.0 or above](https://github.com/gruntjs/grunt-cli)
> -   Access to a working instance of Traffic Ops

Traffic Portal Project Tree Overview
------------------------------------

> -   **traffic\_control/traffic\_portal/app/src** - contains HTML,
>     JavaScript and Sass source files.

Installing The Traffic Portal Developer Environment
---------------------------------------------------

> -   Clone the traffic\_control repository
> -   Navigate to the traffic\_control/traffic\_portal of your cloned
>     repository.
> -   Run `npm install` to install application dependencies into
>     traffic\_portal/node\_modules. Only needs to be done the first
>     time unless traffic\_portal/package.json changes.
> -   Run `bower install` to install client-side dependencies into
>     traffic\_portal/app/bower\_components. Only needs to be done the
>     first time unless traffic\_portal/bower.json changes.
> -   Run `grunt` to package the application into
>     traffic\_portal/app/dist, start a local https server (Express),
>     and start a file watcher.
> -   Navigate to <https://localhost:8443>

Notes
-----

-   The Traffic Portal consumes the Traffic Ops API. By default, Traffic
    Portal assumes Traffic Ops is running on <https://localhost:8444>.
    Temporarily modify traffic\_portal/conf/config.js if you need to
    change the location of Traffic Ops.

