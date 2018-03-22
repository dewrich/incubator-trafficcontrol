Change Logs
===========

/api/1.2/logs
-------------

**GET /api/1.2/logs**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Query Parameters**
>
>   Name                  Required      Description
>   --------------------- ------------- -------------------------------------------------------------
>   `days`                no            The number of days of change logs to return.
>   `limit`               no            The number of rows to limit the response to.
>
> **Response Properties**
>
>   Parameter                      Type            Description
>   ------------------------------ --------------- -----------------------------------------------------------------------------------------------------------------------------
>   `ticketNum`                    string          Optional field to cross reference with any bug tracking systems
>   `level`                        string          Log categories for each entry, examples: 'UICHANGE', 'OPER', 'APICHANGE'.
>   `lastUpdated`                  string          Local unique identifier for the Log
>   `user`                         string          Current user who made the change that was logged
>   `id`                           string          Local unique identifier for the Log entry
>   `message`                      string          Log detail about what occurred
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "ticketNum": null,
>            "level": "OPER",
>            "lastUpdated": "2015-02-04 22:59:13",
>            "user": "userid852",
>            "id": "22661",
>            "message": "Snapshot CRConfig created."
>         },
>         {
>            "ticketNum": null,
>            "level": "APICHANGE",
>            "lastUpdated": "2015-02-03 17:04:20",
>            "user": "userid853",
>            "id": "22658",
>            "message": "Update server odol-atsec-nyc-23.kbaletown.net status=REPORTED"
>         },
>      ],
>     }

| 

**GET /api/1.2/logs/:days/days**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Request Route Parameters**
>
>   Name          Required      Description
>   ------------- ------------- ---------------------
>   `days`        yes           Number of days.
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `ticketNum`                            string          
>   `level`                                string          
>   `lastUpdated`                          string          
>   `user`                                 string          
>   `id`                                   string          
>   `message`                              string          
>
> **Response Example** :
>
>     {
>      "response": [
>         {
>            "ticketNum": null,
>            "level": "OPER",
>            "lastUpdated": "2015-02-04 22:59:13",
>            "user": "userid852",
>            "id": "22661",
>            "message": "Snapshot CRConfig created."
>         },
>         {
>            "ticketNum": null,
>            "level": "APICHANGE",
>            "lastUpdated": "2015-02-03 17:04:20",
>            "user": "userid853",
>            "id": "22658",
>            "message": "Update server odol-atsec-nyc-23.kabletown.net status=REPORTED"
>         }
>      ],
>     }

| 

**GET /api/1.2/logs/newcount**

> Authentication Required: Yes
>
> Role(s) Required: None
>
> **Response Properties**
>
>   Parameter                              Type            Description
>   -------------------------------------- --------------- ---------------------------------------------------------------------------------
>   `newLogcount`                          string          
>
> **Response Example** :
>
>     {
>          "response": {
>             "newLogcount": 0
>          }
>     }
