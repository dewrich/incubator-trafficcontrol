TrafficOps API 1.3
==================

.. toctree::
    :maxdepth: 3


Description
~~~~~~~~~~~

The following REST APIs are used by the Traffic Portal UI along with several Traffic Control backend component and services.

This documentation is fully compliant with the Swagger 2.0 specification



Contact Information
~~~~~~~~~~~~~~~~~~~


Traffic Control Dev List



dev@trafficcontrol.incubator.apache.org



http://traffic-control-cdn.readthedocs.io/en/latest/index.html




License
~~~~~~~


`Apache 2 <https://github.com/apache/incubator-trafficcontrol/blob/master/LICENSE>`_




Base URL
~~~~~~~~

http://localhost:8443/api/1.3
https://localhost:8443/api/1.3

Security
~~~~~~~~


.. _securities_Cookie:

Cookie (API Key)
----------------



**Name:** cookie

**Located in:** header




ASN
~~~




DELETE ``/asns/{id}``
---------------------



Description
+++++++++++

.. raw:: html

    Delete a ASN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the ASN


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/asns/{id}``
------------------



Description
+++++++++++

.. raw:: html

    Retrieve a specific ASN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the ASN


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

ASNs -  ASNsResponse to get the "response" top level key


Type: :ref:`ASNsResponse <d_142c7776db1640a010367d763ec2dbaf>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "asn": 1, 
                "cachegroup": "somestring", 
                "cachegroupId": 1, 
                "id": 1, 
                "lastUpdated": "somestring"
            }, 
            {
                "asn": 1, 
                "cachegroup": "somestring", 
                "cachegroupId": 1, 
                "id": 1, 
                "lastUpdated": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/asns``
-------------



Description
+++++++++++

.. raw:: html

    Retrieve a list of ASNs

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        cachegroup | query | No | string |  |  | Related cachegroup name
        cachegroupId | query | No | string |  |  | Related cachegroup id
        id | query | No | string |  |  | Unique identifier for the CDN
        orderby | query | No | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

ASNs -  ASNsResponse to get the "response" top level key


Type: :ref:`ASNsResponse <d_142c7776db1640a010367d763ec2dbaf>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "asn": 1, 
                "cachegroup": "somestring", 
                "cachegroupId": 1, 
                "id": 1, 
                "lastUpdated": "somestring"
            }, 
            {
                "asn": 1, 
                "cachegroup": "somestring", 
                "cachegroupId": 1, 
                "id": 1, 
                "lastUpdated": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





POST ``/asns``
--------------



Description
+++++++++++

.. raw:: html

    Create a ASN


Request
+++++++



.. _d_093e1492af492722d4fe5ec2cd6748e5:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asn | Yes | integer | int64 |  | The ASN to retrieve

Autonomous System Numbers per APNIC for identifying a service provider
        cachegroup | No | string |  |  | Related cachegroup name
        cachegroupId | No | integer | int64 |  | Related cachegroup id
        id | Yes | integer | int64 |  | ID of the ASN
        lastUpdated | No | string |  |  | LastUpdated

.. code-block:: javascript

    {
        "asn": 1, 
        "cachegroup": "somestring", 
        "cachegroupId": 1, 
        "id": 1, 
        "lastUpdated": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





PUT ``/asns/{id}``
------------------



Description
+++++++++++

.. raw:: html

    Update a ASN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | ID


Request
+++++++



.. _d_093e1492af492722d4fe5ec2cd6748e5:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asn | Yes | integer | int64 |  | The ASN to retrieve

Autonomous System Numbers per APNIC for identifying a service provider
        cachegroup | No | string |  |  | Related cachegroup name
        cachegroupId | No | integer | int64 |  | Related cachegroup id
        id | Yes | integer | int64 |  | ID of the ASN
        lastUpdated | No | string |  |  | LastUpdated

.. code-block:: javascript

    {
        "asn": 1, 
        "cachegroup": "somestring", 
        "cachegroupId": 1, 
        "id": 1, 
        "lastUpdated": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

ASN -  ASNResponse to get the "response" top level key


Type: :ref:`ASNResponse <d_1f0e19c9c52aecd69362cff2c9ab5452>`

**Example:**

.. code-block:: javascript

    {
        "response": {
            "asn": 1, 
            "cachegroup": "somestring", 
            "cachegroupId": 1, 
            "id": 1, 
            "lastUpdated": "somestring"
        }
    }



  
CDN
~~~




DELETE ``/cdns/{id}``
---------------------



Description
+++++++++++

.. raw:: html

    Delete a CDN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the CDN


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/cdns/{id}``
------------------



Description
+++++++++++

.. raw:: html

    Retrieve a specific CDN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the CDN


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

CDNs -  CDNsResponse to get the "response" top level key


Type: :ref:`CDNsResponse <d_368c31d054cad55fe0420cb1159c74b1>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "dnssecEnabled": true, 
                "domainName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "dnssecEnabled": true, 
                "domainName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/cdns``
-------------



Description
+++++++++++

.. raw:: html

    Retrieve a list of CDNs

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        dnssecEnabled | query | No | string |  |  | Enables Domain Name System Security Extensions (DNSSEC) for the CDN
        domainName | query | No | string |  |  | The domain name for the CDN
        id | query | No | string |  |  | Unique identifier for the CDN
        name | query | No | string |  |  | The CDN name for the CDN
        orderby | query | No | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

CDNs -  CDNsResponse to get the "response" top level key


Type: :ref:`CDNsResponse <d_368c31d054cad55fe0420cb1159c74b1>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "dnssecEnabled": true, 
                "domainName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "dnssecEnabled": true, 
                "domainName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





POST ``/cdns``
--------------



Description
+++++++++++

.. raw:: html

    Create a CDN


Request
+++++++



.. _d_73d9f6cb8eca2d8980ff62fe40148b97:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dnssecEnabled | Yes | boolean |  |  | The CDN to retrieve

enables Domain Name Security Extensions on the specified CDN
        domainName | Yes | string |  |  | DomainName of the CDN
        id | Yes | integer | int64 |  | ID of the CDN
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Name of the CDN

.. code-block:: javascript

    {
        "dnssecEnabled": true, 
        "domainName": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





PUT ``/cdns/{id}``
------------------



Description
+++++++++++

.. raw:: html

    Update a CDN

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | ID


Request
+++++++



.. _d_73d9f6cb8eca2d8980ff62fe40148b97:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dnssecEnabled | Yes | boolean |  |  | The CDN to retrieve

enables Domain Name Security Extensions on the specified CDN
        domainName | Yes | string |  |  | DomainName of the CDN
        id | Yes | integer | int64 |  | ID of the CDN
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Name of the CDN

.. code-block:: javascript

    {
        "dnssecEnabled": true, 
        "domainName": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

CDN -  CDNResponse to get the "response" top level key


Type: :ref:`CDNResponse <d_de010dc0562c4d06da46e38e0dcfa92d>`

**Example:**

.. code-block:: javascript

    {
        "response": {
            "dnssecEnabled": true, 
            "domainName": "somestring", 
            "id": 1, 
            "lastUpdated": "somestring", 
            "name": "somestring"
        }
    }



  
DIVISION
~~~~~~~~




DELETE ``/divisions/{id}``
--------------------------



Description
+++++++++++

.. raw:: html

    Delete a Division

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Division


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/divisions/{id}``
-----------------------



Description
+++++++++++

.. raw:: html

    Retrieve a specific Division

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Division


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Divisions -  DivisionsResponse to get the "response" top level key


Type: :ref:`DivisionsResponse <d_ea7c794d6c6c6cf7e9760d6f8e4d4820>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/divisions``
------------------



Description
+++++++++++

.. raw:: html

    Retrieve a list of Divisions

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        name | query | No | string |  |  | Name for this Division
        id | query | No | string |  |  | Unique identifier for the Division
        orderby | query | No | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Divisions -  DivisionsResponse to get the "response" top level key


Type: :ref:`DivisionsResponse <d_ea7c794d6c6c6cf7e9760d6f8e4d4820>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





POST ``/divisions``
-------------------



Description
+++++++++++

.. raw:: html

    Create a Division


Request
+++++++



.. _d_b2fd9a7b8c53650cedaf8db97cec28ab:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        id | No | integer | int64 |  | Division ID
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Division Name

.. code-block:: javascript

    {
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





PUT ``/divisions/{id}``
-----------------------



Description
+++++++++++

.. raw:: html

    Update a Division

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | ID


Request
+++++++



.. _d_b2fd9a7b8c53650cedaf8db97cec28ab:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        id | No | integer | int64 |  | Division ID
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Division Name

.. code-block:: javascript

    {
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Division -  DivisionResponse to get the "response" top level key


Type: :ref:`DivisionResponse <d_b660a4903e14d61b526799bda99db034>`

**Example:**

.. code-block:: javascript

    {
        "response": {
            "id": 1, 
            "lastUpdated": "somestring", 
            "name": "somestring"
        }
    }



  
REGION
~~~~~~




DELETE ``/regions/{id}``
------------------------



Description
+++++++++++

.. raw:: html

    Delete a Region

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Region


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/regions/{id}``
---------------------



Description
+++++++++++

.. raw:: html

    Retrieve a specific Region

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Region


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Regions -  RegionsResponse to get the "response" top level key


Type: :ref:`RegionsResponse <d_c47f9ae41b0cdae2dfaa23b245521a67>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "division": 1, 
                "divisionName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "division": 1, 
                "divisionName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/regions``
----------------



Description
+++++++++++

.. raw:: html

    Retrieve a list of Regions

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        division | query | No | string |  |  | Division ID that refers to this Region
        divisionName | query | No | string |  |  | Division Name that refers to this Region
        id | query | No | string |  |  | Unique identifier for the Region
        orderby | query | No | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Regions -  RegionsResponse to get the "response" top level key


Type: :ref:`RegionsResponse <d_c47f9ae41b0cdae2dfaa23b245521a67>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "division": 1, 
                "divisionName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }, 
            {
                "division": 1, 
                "divisionName": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "somestring"
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





POST ``/regions``
-----------------



Description
+++++++++++

.. raw:: html

    Create a Region


Request
+++++++



.. _d_9fbc6cec29a82ba7aa62f02b0d3f4426:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        division | Yes | integer | int64 |  | DivisionName of the Division
        divisionName | Yes | string |  |  | DivisionName - Name of the Division associated to this Region
        id | No | integer | int64 |  | Region ID
        lastUpdated | No | string |  |  | 
        name | Yes | string |  |  | Region Name

.. code-block:: javascript

    {
        "division": 1, 
        "divisionName": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





PUT ``/regions/{id}``
---------------------



Description
+++++++++++

.. raw:: html

    Update a Region

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | ID


Request
+++++++



.. _d_9fbc6cec29a82ba7aa62f02b0d3f4426:

Body
^^^^

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        division | Yes | integer | int64 |  | DivisionName of the Division
        divisionName | Yes | string |  |  | DivisionName - Name of the Division associated to this Region
        id | No | integer | int64 |  | Region ID
        lastUpdated | No | string |  |  | 
        name | Yes | string |  |  | Region Name

.. code-block:: javascript

    {
        "division": 1, 
        "divisionName": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "somestring"
    }

Responses
+++++++++

**200**
^^^^^^^

Region -  RegionResponse to get the "response" top level key


Type: :ref:`RegionResponse <d_b35b6624e762e00681178828de07477f>`

**Example:**

.. code-block:: javascript

    {
        "response": {
            "division": 1, 
            "divisionName": "somestring", 
            "id": 1, 
            "lastUpdated": "somestring", 
            "name": "somestring"
        }
    }



  
STATUS
~~~~~~




DELETE ``/statuses/{id}``
-------------------------



Description
+++++++++++

.. raw:: html

    Delete a Status

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Status


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/statuses/{id}``
----------------------



Description
+++++++++++

.. raw:: html

    Retrieve a specific Status

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | Id associated to the Status


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Statuses -  StatusesResponse to get the "response" top level key


Type: :ref:`StatusesResponse <d_ecf449ee24100fbf908df418908a72a2>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "description": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "[\"OFFLINE\""
            }, 
            {
                "description": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "[\"OFFLINE\""
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





GET ``/statuses``
-----------------



Description
+++++++++++

.. raw:: html

    Retrieve a list of Statuses

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        name | query | No | string |  |  | The name that refers to this Status
        description | query | No | string |  |  | A short description of the status
        id | query | No | string |  |  | Unique identifier for the Status
        orderby | query | No | string |  |  | 


Request
+++++++


Responses
+++++++++

**200**
^^^^^^^

Statuses -  StatusesResponse to get the "response" top level key


Type: :ref:`StatusesResponse <d_ecf449ee24100fbf908df418908a72a2>`

**Example:**

.. code-block:: javascript

    {
        "response": [
            {
                "description": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "[\"OFFLINE\""
            }, 
            {
                "description": "somestring", 
                "id": 1, 
                "lastUpdated": "somestring", 
                "name": "[\"OFFLINE\""
            }
        ]
    }

**400**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





POST ``/statuses``
------------------



Description
+++++++++++

.. raw:: html

    Create a Status


Request
+++++++



.. _d_2e0616e8144a473269245df2f1cc8127:

Body
^^^^

A Single Statuses Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        description | No | string |  |  | The Statuses to retrieve

description of the status type
        id | Yes | integer | int64 |  | ID of the Status
        lastUpdated | No | string |  |  | The Time / Date this server entry was last updated
        name | No | string |  | {'enum': ['["OFFLINE"', ' "ONLINE"', ' "ADMIN_DOWN"', ' "REPORTED"', ' "CCR_IGNORE"', ' "PRE_PROD"]']} | 

.. code-block:: javascript

    {
        "description": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "[\"OFFLINE\""
    }

Responses
+++++++++

**200**
^^^^^^^

Alerts - informs the client of server side messages


Type: array of :ref:`Alert <d_de560155dd754ac301d784df6144eb11>`


**Example:**

.. code-block:: javascript

    [
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }, 
        {
            "level": "[\"success\"", 
            "text": "somestring"
        }
    ]





PUT ``/statuses/{id}``
----------------------



Description
+++++++++++

.. raw:: html

    Update a Status

Parameters
++++++++++

.. csv-table::
    :delim: |
    :header: "Name", "Located in", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 15, 10, 10, 10, 20, 30

        id | path | Yes | integer | int64 |  | ID


Request
+++++++



.. _d_2e0616e8144a473269245df2f1cc8127:

Body
^^^^

A Single Statuses Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        description | No | string |  |  | The Statuses to retrieve

description of the status type
        id | Yes | integer | int64 |  | ID of the Status
        lastUpdated | No | string |  |  | The Time / Date this server entry was last updated
        name | No | string |  | {'enum': ['["OFFLINE"', ' "ONLINE"', ' "ADMIN_DOWN"', ' "REPORTED"', ' "CCR_IGNORE"', ' "PRE_PROD"]']} | 

.. code-block:: javascript

    {
        "description": "somestring", 
        "id": 1, 
        "lastUpdated": "somestring", 
        "name": "[\"OFFLINE\""
    }

Responses
+++++++++

**200**
^^^^^^^

Status -  StatusResponse to get the "response" top level key


Type: :ref:`StatusResponse <d_260e178213f610415693daa4a5453966>`

**Example:**

.. code-block:: javascript

    {
        "response": {
            "description": "somestring", 
            "id": 1, 
            "lastUpdated": "somestring", 
            "name": "[\"OFFLINE\""
        }
    }



  
Data Structures
~~~~~~~~~~~~~~~

.. _d_093e1492af492722d4fe5ec2cd6748e5:

ASN Model Structure
-------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        asn | Yes | integer | int64 |  | The ASN to retrieve

Autonomous System Numbers per APNIC for identifying a service provider
        cachegroup | No | string |  |  | Related cachegroup name
        cachegroupId | No | integer | int64 |  | Related cachegroup id
        id | Yes | integer | int64 |  | ID of the ASN
        lastUpdated | No | string |  |  | LastUpdated

.. _d_1f0e19c9c52aecd69362cff2c9ab5452:

ASNResponse Model Structure
---------------------------

A Single ASN Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | :ref:`ASN <d_093e1492af492722d4fe5ec2cd6748e5>` |  |  | 

.. _d_142c7776db1640a010367d763ec2dbaf:

ASNsResponse Model Structure
----------------------------

A List of ASNs Response

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | array of :ref:`ASN <d_093e1492af492722d4fe5ec2cd6748e5>` |  |  | in: body

.. _d_de560155dd754ac301d784df6144eb11:

Alert Model Structure
---------------------

Alerts that inform the client of server side information

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        level | No | string |  | {'enum': ['["success"', ' "info"', ' "warn"', ' "error"]']} | Severity
        text | No | string |  |  | Message

.. _d_73d9f6cb8eca2d8980ff62fe40148b97:

CDN Model Structure
-------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        dnssecEnabled | Yes | boolean |  |  | The CDN to retrieve

enables Domain Name Security Extensions on the specified CDN
        domainName | Yes | string |  |  | DomainName of the CDN
        id | Yes | integer | int64 |  | ID of the CDN
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Name of the CDN

.. _d_de010dc0562c4d06da46e38e0dcfa92d:

CDNResponse Model Structure
---------------------------

A Single CDN Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | :ref:`CDN <d_73d9f6cb8eca2d8980ff62fe40148b97>` |  |  | 

.. _d_368c31d054cad55fe0420cb1159c74b1:

CDNsResponse Model Structure
----------------------------

A List of CDNs Response

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | array of :ref:`CDN <d_73d9f6cb8eca2d8980ff62fe40148b97>` |  |  | in: body

.. _d_b2fd9a7b8c53650cedaf8db97cec28ab:

Division Model Structure
------------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        id | No | integer | int64 |  | Division ID
        lastUpdated | No | string |  |  | LastUpdated
        name | Yes | string |  |  | Division Name

.. _d_b660a4903e14d61b526799bda99db034:

DivisionResponse Model Structure
--------------------------------

A Single Division Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | :ref:`Division <d_b2fd9a7b8c53650cedaf8db97cec28ab>` |  |  | 

.. _d_ea7c794d6c6c6cf7e9760d6f8e4d4820:

DivisionsResponse Model Structure
---------------------------------

A List of Divisions Response

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | array of :ref:`Division <d_b2fd9a7b8c53650cedaf8db97cec28ab>` |  |  | in: body

.. _d_9fbc6cec29a82ba7aa62f02b0d3f4426:

Region Model Structure
----------------------

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        division | Yes | integer | int64 |  | DivisionName of the Division
        divisionName | Yes | string |  |  | DivisionName - Name of the Division associated to this Region
        id | No | integer | int64 |  | Region ID
        lastUpdated | No | string |  |  | 
        name | Yes | string |  |  | Region Name

.. _d_b35b6624e762e00681178828de07477f:

RegionResponse Model Structure
------------------------------

A Single Region Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | :ref:`Region <d_9fbc6cec29a82ba7aa62f02b0d3f4426>` |  |  | 

.. _d_c47f9ae41b0cdae2dfaa23b245521a67:

RegionsResponse Model Structure
-------------------------------

A List of Regions Response

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | array of :ref:`Region <d_9fbc6cec29a82ba7aa62f02b0d3f4426>` |  |  | in: body

.. _d_260e178213f610415693daa4a5453966:

StatusResponse Model Structure
------------------------------

A Single Status Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | :ref:`Statuses <d_2e0616e8144a473269245df2f1cc8127>` |  |  | 

.. _d_2e0616e8144a473269245df2f1cc8127:

Statuses Model Structure
------------------------

A Single Statuses Response for Update and Create to depict what changed

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        description | No | string |  |  | The Statuses to retrieve

description of the status type
        id | Yes | integer | int64 |  | ID of the Status
        lastUpdated | No | string |  |  | The Time / Date this server entry was last updated
        name | No | string |  | {'enum': ['["OFFLINE"', ' "ONLINE"', ' "ADMIN_DOWN"', ' "REPORTED"', ' "CCR_IGNORE"', ' "PRE_PROD"]']} | 

.. _d_ecf449ee24100fbf908df418908a72a2:

StatusesResponse Model Structure
--------------------------------

A List of Statuses Response that depict the state of a server

.. csv-table::
    :delim: |
    :header: "Name", "Required", "Type", "Format", "Properties", "Description"
    :widths: 20, 10, 15, 15, 30, 25

        response | No | array of :ref:`Statuses <d_2e0616e8144a473269245df2f1cc8127>` |  |  | in: body

