#!/bin/bash
source ./.env

# Heroku/Atlas MongoDb connection
user=$MONGODB_user
password=$MONGODB_password
host=$MONGODB_host
port=$MONGODB_port
appname=$MONGODB_appname

# Dump location
HEROKU_db=heroku_1rxwd02n
data_importdir=$CONTAINER_datapath/exports/$HEROKU_db

# Mongo database collections to import
arr_collections=(
    ## For Azure WebApp deployment with Consmos/MongoDb, do not import  auth collections
    ##'auth_roles'
    ##'auth_subjects'
    ##'settings'

    'activity'
    'profile'
    'devicestatus'
    'entries'
    'treatments'
    'food'

    )


# Name of mongodb container to execute commands
container_name=$CONTAINER_name

# Import data into database
db=test
dropcollection="--drop"

# Restore database from storage on container to db
for collection in "${arr_collections[@]}"
do
    # Prepare statement
    cmd="mongoimport -v --uri mongodb://$user:$password@$host:$port/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@$appname@ --db=${db} --collection=${collection} ${dropcollection} --file=${data_importdir}/${collection}.json"
    echo $cmd

    # Run command from container
    docker exec -it $container_name $cmd
done
