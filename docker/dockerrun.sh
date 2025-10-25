#!/bin/bash

sudo systemctl restart docker
docker run -it --rm -v `pwd`/.:/yocto/ \
    --name dockerYP --hostname dockerYP -t dockeryp:24.04 /bin/bash
