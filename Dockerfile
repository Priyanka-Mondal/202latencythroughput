FROM ubuntu 
MAINTAINER priyanka (priyanka02010@gmail.com)
COPY . /docker-curriculum/throughput
WORKDIR  /docker-curriculum/throughput
RUN apt-get update && apt-get install -y openssl 
RUN apt-get update && apt-get install -y libssl-dev 
RUN apt-get update && apt-get -y install linux-tools-`uname -r`
RUN apt-get update && apt-get -y install gcc
RUN apt-get update && apt-get -y install git
RUN git clone https://github.com/andikleen/pmu-tools
RUN export PATH=$PATH:`pwd`
RUN apt-get update && apt-get -y install python-matplotlib
RUN gcc 202throughput.c -o tp -lcrypto
CMD ["./localperf.sh"]
