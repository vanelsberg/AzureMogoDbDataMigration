#!/bin/bash
# source ../../.env

# Sample: Dump Azure MongoDb database to local comntainer storage
# It assumes you have a docker instance named "mongodb4" running MongoDb client tools

# MongoDb connection
user=*******
password=******
host=******.mongo.cosmos.azure.com
port=10255
appname=******

# Dump location
datadumpdir=./data/dumps/az

# Dump database to local storage
cmd="mongodump -vvvvv --uri mongodb://$user:$password@$host:$port/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@$appname@ --out=${datadumpdir}"
echo $cmd

# Run dump from **container** (note: dump will be located on container)
docker exec -it mongodb4 $cmd

# Optionally: Copy container data local with 'docker cp mongodb4:./data ./'

echo "Done (datadump is on Docker volume - use get_data2local.sh to get the data locally)."

