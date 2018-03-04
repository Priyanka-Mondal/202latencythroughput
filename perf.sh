#!/bin/bash
# r3f24 all inst that miss L2  24H 3FH:	
#24H EFH L2_RQSTS.REFERENCES  All requests to L2. 
# r08d1 Retired load instructions missed L1 cache as data 
# r01d1 retired load instructions with L1 cache hits as data 
max=0
one=999990000
two=222220000
three=66660000
four=4444444
five=1111111
PID_LIST=0
sl=0
inst=0
ic=0
echo " " > results.perf
for l in 1 2 4 8; do {
max=$l
for k in 1 2 3 4 5; do {
unset PID_LIST 
if [ 1 = $k ]
then
inst=$one
sl=400
ic=X
elif [ 2 = $k ]
then
inst=$two
sl=130
ic=X/4
elif [ 3 = $k ]
then
inst=$three
sl=25
ic=X/16
elif [ 4 = $k ]
then
inst=$four
sl=5
ic=X/64
else
inst=$five
sl=1
ic=X/256
fi
for j in `seq 1 $max`; do {
cmd="./aes1 "$inst
#echo $cmd
$cmd & pid=$!
PID_LIST+="$pid,";
} done
echo $max" Processes with\"$ic\" instructions" >> results.perf
#echo $PID_LIST 
#perf stat -p $PID_LIST & 
perf stat -B -e task-clock,instructions,cycles,branches,branch-misses,L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,ref24,r3f24,r08d1,r01d1 -p $PID_LIST -o perf.out1 &
pp=$!
sleep $sl
kill -INT $pp
cat perf.out1 >> results.perf
} done
} done
cat results.perf
echo "PLEASE PRESS CTRL+C to STOP the docker run"
perf stat -p $PID_LIST -o extra.out
echo "All processes have completed"
