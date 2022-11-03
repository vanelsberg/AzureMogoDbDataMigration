#!/bin/bash
source ./.env

# Export Atlas MongoDb database collection to .json files
user=$HEROKU_user
password=$HEROKU_password
host=$HEROKU_host
db=$HEROKU_db

data_exportdir=$CONTAINER_datapath/exports/$db

arr_collections=(
    'auth_roles'
    'auth_subjects'

    'activity'
    'devicestatus'
    'entries'
    'profile'
    'treatments'

    #'settings'
    #'food'
    )

for collection in "${arr_collections[@]}"
do
    # Prepare statement
    cmd="mongoexport -v --uri mongodb+srv://$user:$password@$host/$db --collection=${collection} --out=${data_exportdir}/${collection}.json"
    echo $cmd

    # Run command from container
    docker exec -it $CONTAINER_name $cmd
done

echo "Done (data export is local path '${data_exportdir}')."



