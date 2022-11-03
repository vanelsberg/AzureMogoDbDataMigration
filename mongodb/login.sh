#!/bin/bash
source ./.env

#runsudo="sudo"

$runsudo docker exec -it $CONTAINER_name /bin/bash
