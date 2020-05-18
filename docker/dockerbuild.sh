#!/bin/bash

docker build . -t dockeryp:20.05
docker image prune -f
