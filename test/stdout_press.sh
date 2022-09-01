#!/bin/bash

k1_str=`head -c 1024 /dev/urandom |base64|xargs echo -n`

for((i=1;i<=10240;i++));  
do
  echo $i >> /tmp/idx.txt 
  echo $k1_str
done 