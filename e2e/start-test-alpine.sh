#!/bin/sh

if ! [ -x "$(command -v bash)" ]; then
  echo installing bash
  apk --no-cache add bash
fi
sh ./test.bash
