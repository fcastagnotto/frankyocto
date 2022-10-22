#!/bin/bash

docker build . -t dockeryp:22.10.2
docker image prune -f
