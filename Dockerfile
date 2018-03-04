FROM ubuntu 
MAINTAINER priyanka (priyanka02010@gmail.com)
COPY . /docker-curriculum/throughput
WORKDIR  /docker-curriculum/throughput
RUN apt-get update && apt-get install -y openssl 
RUN apt-get update && apt-get install -y libssl-dev 
RUN apt-get update && apt-get -y install linux-tools-`uname -r`
RUN apt-get update && apt-get -y install gcc
RUN gcc aes1.c -o aes1 -lcrypto
CMD ["./localperf.sh"]
