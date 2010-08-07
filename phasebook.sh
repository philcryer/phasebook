#!/bin/bash

# phasebook.sh

host="127.0.0.1"
port="5984"
db="test"
start="4"
end="10"

for i in `seq $start $end`;
	do
		# get current record id from facebook as a json document
		curl --header 'Content-Type: application/json' http://graph.facebook.com/$i -o $i.json

		# determine user's facebook id
		uuid=`cat $i.json | cut -d\" -f4`

		# define couchdb host to post to		
		url="http://$host:$port/$db"

		# ensure this record has a first name, which will tell us if it's an active/public record
		if grep first_name $i.json >/dev/null; then 
			# if so, post the record of the user into couchdb
			curl -X POST $url --header 'Content-Type: application/json' --data @$i.json
		fi

		# clean up
		rm $i.json
	done

exit 0
