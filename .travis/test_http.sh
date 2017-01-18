#!/bin/sh

echo -n 'HTTP test: '
curl -vsf -H 'Accept-Encoding: gzip' 'http://127.0.0.1:80/' &> /dev/stdout
RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo OK
    exit 0
else
    echo FAIL
    echo $RESULT
fi
