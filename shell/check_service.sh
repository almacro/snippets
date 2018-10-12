#!/usr/bin/env bash
#
# restart any KPI dockers if they are found dead

function check_container {
    STAT=$(docker inspect $1 | jq '.[].State.Status')
    if [[ "$STAT" != "running" ]]
    then
	docker restart $1
    fi
}

CONTAINERS="zookeeper kafka elasticsearch logstash kibana python-producer python-consumer"

for c in $(echo $CONTAINERS)
do
    #echo $c
    check_container $c
done
