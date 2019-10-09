#!/bin/bash


curl 'http://localhost:8080/save/doc'
curl 'http://localhost:8080/save/doc'  -H 'Content-Type: application/x-www-form-urlencoded'    --data 'body=hellotestbenchwashere'

acceptedRate=1000

if [[ $(printf  %.0f `ab -k  -T 'application/x-www-form-urlencoded'    -n 1000 -c 1 'http://localhost:8080/view/doc' | grep 'Requests per second' | grep -oE [0-9]+.[0-9]+ `) -gt acceptedRate ]] 
then
    echo PASS
else
   echo Acceptance Criteria Failed
   exit 1
fi

