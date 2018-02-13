#!/usr/bin/env bash

unset DEBUG
#export DEBUG=true
#rm -rf client models
swagger generate client -f ../docs/swagger.json

echo "successfully generated the swagger Golang client code"
