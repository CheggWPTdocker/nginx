#!/bin/sh

echo -n 'GZIP test: '
curl -vsf -H 'Accept-Encoding: gzip' 'http://localhost:8080/' &> /dev/stdout | grep -i 'Content-Encoding: gzip'
RESULT=$?
if [ $RESULT -eq 0 ]; then
    echo OK
    exit 0
else
    echo FAIL
    exit $RESULT
fi
