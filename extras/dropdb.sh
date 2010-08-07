#!/bin/bash

# deletedb.sh

db="test"
url="http://127.0.0.1:5984/$db"
secret="name:password"

curl -X DELETE $url --user $secret
curl -X PUT $url --user $secret

exit 0
