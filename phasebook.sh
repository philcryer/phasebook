#!/bin/bash

db="test"
url="http://127.0.0.1:5984/$db"
start="4"
end="10"

for i in `seq $start $end`;
	do
		curl http://graph.facebook.com/$i -o $i.json
		curl -X POST -d @$i.json $url
		rm $i.json
	done   
exit 0
