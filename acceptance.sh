#!/usr/bin/env sh

if [ ! -f ./main ]; then
    go build -o main .
fi


./main &
PROC_ID=$!

curl 'http://localhost:8080/save/doc'
curl 'http://localhost:8080/save/doc'  -H 'Content-Type: application/x-www-form-urlencoded'    --data 'body=hellotestbenchwashere'

acceptedRate=1000

if ! [ -x "$(command -v ab)" ]; then
  echo installing ab
  apk --no-cache add apache2-utils
fi

currentRate=$(printf  %.0f `ab -k  -T 'application/x-www-form-urlencoded'    -n 1000 -c 1 'http://localhost:8080/view/doc' | grep 'Requests per second' | grep -oE [0-9]+.[0-9]+ `)

if [[ $currentRate -gt $acceptedRate ]] 
then
    kill -9 $PROC_ID
    echo Current Rate $currentRate
    echo PASS
else
   kill -9 $PROC_ID
   echo Acceptance Criteria Failed
   echo Current Rate $currentRate
   exit 1
fi

