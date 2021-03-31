#!/bin/bash

export node_count=$1
if [[ -z $node_count ]]
then
export node_count=5; echo "No node_count value provided, using default value '$node_count'"
fi

echo "###  Deploying Selenium Grid, please hold on ###"
docker-compose up -d --remove-orphans
sleep 10
if [ "$(curl http://localhost:4444/wd/hub/status | jq -r '.value.ready')" = "true" ];
    then echo "Selenium Grid is up and running"; else echo >&2 "Selenium Grid failed to start"; exit 1; fi

echo "Building Image & Running Tests"
docker-compose -f ./docker-compose-python/compose-tests.yaml up --remove-orphans --build