#!/bin/bash

echo "Waiting for postgresql service..."

while [ "$(nc -v -z -w 3 postgresql 2> /dev/null; echo $?)" == "1" ]; do
	sleep 10s
done

source /app/gogs/docker/start.sh
