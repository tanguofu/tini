#!/bin/bash 

DATE=`date "+%Y%m%d"`
COMMITID=`git rev-parse --short HEAD`
BRANCH=`git symbolic-ref --short -q HEAD|tr / _ `

REPO=ccr.ccs.tencentyun.com/ti-platform
APP=tini
TAG=${BRANCH}-${COMMITID}-${DATE}
DOCKER_IMAGE_NAME=${REPO}/${APP}:${TAG}
DOCKER_IMAGE_NAME_LATEST=${REPO}/${APP}:latest

# x86-64
docker buildx build --platform linux/amd64 --pull --push --network=host -t $DOCKER_IMAGE_NAME --build-arg BUILDIMAGE=mirrors.tencent.com/tlinux/tlinux3.1-minimal:latest  -f Dockerfile.tlinux .
docker tag $DOCKER_IMAGE_NAME $DOCKER_IMAGE_NAME_LATEST
docker push $DOCKER_IMAGE_NAME_LATEST

# aarch64
docker buildx build --platform linux/arm64 --pull --push --network=host -t $DOCKER_IMAGE_NAME-aarch64 --build-arg BUILDIMAGE=mirrors.tencent.com/tlinux/tlinux3.1-aarch64-minimal:latest  -f Dockerfile.tlinux .
docker tag $DOCKER_IMAGE_NAME-aarch64  $DOCKER_IMAGE_NAME_LATEST-aarch64 
docker push $DOCKER_IMAGE_NAME_LATEST-aarch64 

# copy local
docker run --rm -v `pwd`:`pwd` -w `pwd` $DOCKER_IMAGE_NAME /bin/bash -c "cp -f /tini/build/tini ."