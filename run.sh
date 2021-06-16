#!/bin/bash

export LOCAL_USER=`id -un`
export LOCAL_UID=`id -u`
export LOCAL_GID=`id -g`
#sudo -E docker-compose build --build-arg LOCAL_USER=`id -un` --build-arg LOCAL_UID=`id -u` --build-arg LOCAL_GID=`id -g`
sudo -E docker-compose build
sudo -E docker-compose up&

