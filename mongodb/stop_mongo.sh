#!/bin/bash
source ./.env

echo "Stopping container ${CONTAINER_name}"

$runsudo docker stop $CONTAINER_name
