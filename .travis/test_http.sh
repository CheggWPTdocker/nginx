#!/bin/sh

echo -n 'HTTP test: '
RESULT=`curl -vsf -H 'Accept-Encoding: gzip' 'http://localhost:80/' &> /dev/stdout | grep -i '200 OK'`
if [ $RESULT -eq 0 ]; then
    echo OK
    exit 0
else
    echo FAILED with $RESULT
    exit $RESULT
fi
