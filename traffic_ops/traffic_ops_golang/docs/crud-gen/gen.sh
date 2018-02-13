#!/usr/bin/env bash

unset DEBUG
#export DEBUG=true
go run generator.go

cp output/* ..

rm -rf output

cd ..
swagger generate spec -o ./swagger.json
echo "successfully generated swagger doc to: ../docs/swagger.json"

