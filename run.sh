#!/bin/sh -e
############################################NOTE############################################################
# 1.How to run? sudo ./run.sh <an integer argument> If you dont give an argument it will take 20 as default. #
# 2.The integer is the number of RSA key value pairs you want to generate.				   #
# 3. Latencies are recorded for each key-pair generation.					           #
# 4.WARNING: DO NOT GIVE A BIG INTEGER VALUE AS ARGUMENT. Because it generates .pem files to store the     #
#   private-public keys. It will consume lots of space if you give a large value.                          #
# 5.I have tried with 2000 in my local machine and plotted the graph. 					   #
# 6.You can see the .pem files with "ls"  and "cat privatex.pem"  commands at the end 			   #
#   of the execution of this script. All the latencies are stored in a file named latency_file. 	   #
# 7.Do "cat latency_file" to see the contents.It also records the average latency at the end of file.      #	
# 8.Please use sudo while executing this script.	 						   #			
############################################################################################################
if (ls | grep public)
then echo "removing old Key files"  
rm -r -f public*
fi

if(ls | grep private)
then echo "removing old Key files"
rm -r -f private*
fi
IMAGE=27091991/202latency
if [ "$#" -eq 0 ]; then
sudo docker run -it $IMAGE ./latency 
max=20 
else
sudo docker run -it $IMAGE ./latency $1
max=$1
fi
ID=`sudo docker ps -a | grep 27091991/202latency | awk '{print $1}'`
echo $ID > file 
ID2=`awk '{print $1}' file`
echo "key files are being copied. [execute ./delete.sh to delete them, other-wise they will stay in the current folder]"  
public="public"
private="private"
for i in `seq 1 $max`
do
public1=$public$i.pem
private1=$private$i.pem
sudo docker cp $ID2:/priyanka-mondal-202/latency/$public1 .
sudo docker cp $ID2:/priyanka-mondal-202/latency/$private1 .
done
echo "latencies are copied into file called --\"latency_file\"-- in the current folder"
sudo docker cp $ID2:/priyanka-mondal-202/latency/latency_file .
echo "--------------------------------------------------------------DONE-----------------------------------------------------------------"
rm -r file
