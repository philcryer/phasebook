#!/bin/bash

# phasebook.sh

host="127.0.0.1"
port="5984"
db="test"
start="4"
end="5"

for i in `seq $start $end`;
	do
		# get user's record from facebook as a json document
		curl http://graph.facebook.com/$i -o $i.json

		# determine user's facebook id
		uuid=`cat $i.json | cut -d\" -f4`

		# define couchdb host to post to		
		url="http://$host:$port/$db"

		# post user's data into couchdb
		curl -X POST $url --header 'Content-Type: application/json' --data @$i.json

		# clean up
		rm $i.json
	done

exit 0
