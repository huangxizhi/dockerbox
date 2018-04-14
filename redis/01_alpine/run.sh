#!/bin/bash

PC_PORT=6479
DOCKER_NAME="redis"

REPO="redis"
TAG="4-alpine"
DOCKER_IMG="$REPO:$TAG"

#exist=`docker ps -a |grep $DOCKER_NAME`
exist=`docker ps | awk '{if($NF=="'"$DOCKER_NAME"'"){print $NF}}'`
if [ -n "$exist" ]; then
   echo "exist docker name:$DOCKER_NAME, delete it"
   docker rm -f -v $DOCKER_NAME
fi

curdir=`pwd`
datadir=${curdir}/data
CMD="docker run -d -p $PC_PORT:6379 --name $DOCKER_NAME -v ${datadir}:/data -t $DOCKER_IMG redis-server --appendonly yes" 
echo $CMD
eval $CMD

