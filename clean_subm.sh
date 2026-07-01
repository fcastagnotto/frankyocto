#!/bin/bash

#---------------------------------------------------------------------------------
# Description:      Clean the submodules, set to correct branches
# Version:          0.1
# Date:             2026-06-18
# Author:           Francesco Castagnotto <fcastagnotto@linux.com>
#---------------------------------------------------------------------------------

git submodule deinit -f --all
rm -rf .git/modules/sources
rm -rf sources/meta-openembedded sources/meta-raspberrypi sources/poky \
       sources/meta-rauc sources/meta-rauc-community sources/meta-qbee \
       sources/meta-lts-mixins sources/meta-ti sources/meta-arm

git submodule sync --recursive
git submodule update --init --recursive --remote
git submodule foreach 'branch=$(git config -f "$toplevel/.gitmodules" submodule.$name.branch)
echo "== $name -> $branch =="
git fetch origin
git checkout "$branch"
git pull --ff-only origin "$branch"
'

