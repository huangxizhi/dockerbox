#!/bin/bash

HOST_PORT=3307
DOCKER_NAME="mysql"
MYSQL_USER=root
MYSQL_PWD=666666

REPO="mysql"
TAG="5.7.21"
DOCKER_IMG="$REPO:$TAG"

#exist=`docker ps -a |grep $DOCKER_NAME`
exist=`docker ps -a| awk '{if($NF=="'"$DOCKER_NAME"'"){print $NF}}'`
if [ -n "$exist" ]; then
   echo "exist docker name:$DOCKER_NAME, delete it"
   docker rm -f -v $DOCKER_NAME
fi

curdir=`pwd`
datadir=${curdir}/data
CMD="docker run --name $DOCKER_NAME -p $HOST_PORT:3306 -v ${datadir}:/var/lib/mysql -e MYSQL_USER=${MYSQL_USER} -e MYSQL_ROOT_PASSWORD=${MYSQL_PWD} -d $DOCKER_IMG"
echo $CMD
eval $CMD

