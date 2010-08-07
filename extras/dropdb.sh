#!/bin/bash

# deletedb.sh

db="test"
url="http://127.0.0.1:5984/$db"

#curl -X DELETE "$url"
curl -X DELETE http://couchdb.fak3r.com/_utils/database.html?test

exit 0
