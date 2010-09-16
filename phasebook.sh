#!/bin/bash

# phasebook.sh

# define id range
start="100"
end="100"

# define couchd env
host="127.0.0.1"
port="5984"
db="test"
url="http://$host:$port/$db"

for i in `seq $start $end`;
	do
		# get current record id from facebook's graph api as a json document
		curl --header 'Content-Type: application/json' http://graph.facebook.com/$i -o $i.json

		# ensure this record has a first name, which will tell us if it's an active/public record
		if grep first_name $i.json >/dev/null; then 

			# if so, determine the facebook user's record id
			uuid=`cat $i.json | cut -d\" -f4`
				
			# use this when adding the new record, or updating an existing one
			url="$url/$uuid"

			# insert record into couchdb, first creating a new couchdb _id so it matches their facebook user id
			curl -X PUT $url --header 'Content-Type: application/json' --data @$i.json



#			curl -X POST $url/100 -d@$i.json

#POST $url --header 'Content-Type: application/json' --data @$i.json

			exit 0

			# post the record of the user into couchdb
			curl -X POST $url --header 'Content-Type: application/json' --data @$i.json

			# get current record id via facebook's fql api
			curl --header 'Content-Type: application/json' 'http://api.facebook.com/method/fql.query?format=json&query=SELECT%20uid,name,first_name,middle_name,last_name,locale,profile_update_time,meeting_for,religion,timezone,birthday,birthday_date,hometown_location,affiliations,meeting_sex%20FROM%20user%20WHERE%20uid%20IN%20(4)' -o $i.json

			# normalize json to remove [ and ]
			cat $i.json | cut -d[ -f2 | cut -d] -f1 > $i.json.normal; mv $i.json.normal $i.json

		fi

		# clean up
#		rm $i.json
	done

exit 0
