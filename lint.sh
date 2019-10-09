#!/bin/sh

if ! [ -x "$(command -v golint)" ]; then
  apk --no-cache add git
  go get -u  golang.org/x/lint/golint
fi

golint .
