FROM gcc:4.9
MAINTAINER priyanka (priyanka02010@gmail.com)
COPY . /priyanka-mondal-202/latency
WORKDIR  /priyanka-mondal-202/latency
RUN apt-get update \
&& apt-get install -y openssl  
RUN gcc 202latency.c -o latency -lcrypto
#CMD ["./latency"]

