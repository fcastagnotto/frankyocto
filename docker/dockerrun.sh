#!/bin/bash

sudo systemctl restart docker
docker run -it --rm -v `pwd`/.:/yocto/ \
    --name dockerYP --hostname dockerYP \
  --dns 8.8.8.8 --dns 1.1.1.1 --network host -t dockeryp:24.04 /bin/bash
