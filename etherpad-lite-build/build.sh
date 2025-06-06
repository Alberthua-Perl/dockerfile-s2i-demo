#!/bin/bash

cp ./npmrc ./etherpad-lite-postgres/.npmrc
cp settings.json ./etherpad-lite-postgres

podman build -t etherpad-lite-postgres:v1.0 --format=docker .
# use --format option to be compatible with docker image format
