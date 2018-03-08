#!/bin/bash

echo "--------------------------------"
echo "PLEASE GIVE PASSWORD IF PROMPTED"
echo "--------------------------------"
sudo apt-get -y install git
git clone https://github.com/Priyanka-Mondal/202throughput.git
cd 202throughput
chmod +x localperf.sh
chmod +x perf.sh
sudo docker build -t 27091991/th10 .
sudo docker run -it -d --security-opt seccomp=mysec.json 27091991/th10 
status=$?
if [ $status -ne 0 ];then
echo "running withpt seccom"  
sudo docker run -it 27091991/th10
else
sleep 30
#pp=$!
#kill -INT $pp  
echo "OK:"
fi
#if sudo docker run -it --security-opt seccomp=mysec.json 27091991/th10 ; then
#    echo "Command succeeded"
#else sudo docker run -it 27091991/th10
#    echo "Command failed"
#fi
