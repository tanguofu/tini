#!/bin/bash 

DATE=`date "+%Y%m%d"`
COMMITID=`git rev-parse --short HEAD`
BRANCH=`git symbolic-ref --short -q HEAD|tr / _ `

REPO=ccr.ccs.tencentyun.com/ti-platform
APP=tini
TAG=${BRANCH}-${COMMITID}-${DATE}
DOCKER_IMAGE_NAME=${REPO}/${APP}:${TAG}

docker buildx build --platform linux/amd64 --pull --network=host -t $DOCKER_IMAGE_NAME  -f Dockerfile.tlinux .
docker run --rm -v `pwd`:`pwd` -w `pwd` $DOCKER_IMAGE_NAME /bin/bash -c "cp -f /tini/build/tini ."