#!/bin/sh -e
echo "please give password if prompted"
IMAGE=27091991/202latency
sudo docker pull $IMAGE
if (ls | grep run)
then
chmod +x "run.sh"
fi
#docker build -t $IMAGE .
