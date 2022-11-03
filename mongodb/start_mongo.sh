#!/bin/bash
source ./.env

local_path=$CONTAINER_localdatapath
container_path=$CONTAINER_datapath

# Create output path so whe are owner
mkdir -p $local_path/exports

echo "Starting container ${CONTAINER_name}, local data mounted: '$local_path'"

$runsudo docker run -d --rm -v "${local_path}:${container_path}" --name ${CONTAINER_name} -it mongo:4.4
$runsudo docker ps

