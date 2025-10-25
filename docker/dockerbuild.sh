#!/bin/bash

docker build . -t dockeryp:24.04
docker image prune -f
