#!/bin/bash
max=1
one=999990000
two=222220000
three=66660000
four=14444444
five=4444444
inst=$two
for j in `seq 1 $max`; do {
cmd="./aes1 "$inst
#echo $cmd
$cmd & pid=$!
PID_LIST+="$pid,";
} done
echo $max" Processes with\"$ic\" instructions" >> results.perf
#echo $PID_LIST
#perf stat -p $PID_LIST &
perf stat -B -e task-clock,instructions,cycles,branches,branch-misses,L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses,ref24,r3f24,r08d1,r01d1 -p $PID_LIST 

