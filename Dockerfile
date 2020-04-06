# Pull base image.
FROM ubuntu:16.04
#FROM alpine:3.7

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Define workdir
WORKDIR /root

# Install some tools: gcc build tools, unzip, etc
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential unzip cmake git libgmp3-dev libssl-dev sudo binfmt-support clang clang-3.8 file libclang-common-3.8-dev libclang1-3.8 libffi-dev libllvm3.8 libmagic1 libobjc-5-dev libobjc4 libpipeline1 libpython-stdlib libpython2.7-minimal libpython2.7-stdlib libtinfo-dev llvm-3.8 llvm-3.8-dev llvm-3.8-runtime mime-support python python-minimal python2.7 python2.7-minimal wget libboost-dev

#Install a recent enough version of NTL to have BasicThreadPool...
RUN wget http://www.shoup.net/ntl/ntl-11.4.3.tar.gz && \
	tar -xf ntl-11.4.3.tar.gz && \
	cd ntl-11.4.3/src && \
	./configure NTL_GMP_LIP=on NTL_THREADS=off NTL_THREAD_BOOST=off NTL_EXCEPTIONS=on NTL_STD_CXX11=on && \
	make && \
	make install

RUN cd /usr/src/ && \
    mkdir libpolycrypto && \
    cd libpolycrypto

WORKDIR /usr/src/libpolycrypto
#WORKDIR /usr/src/

#COPY src/libpolycrypto/ libpolycrypto/

RUN git clone https://github.com/tyurek/libpolycrypto-docker.git && \
#    pwd && \
#    ls && \
    cd libpolycrypto-docker/src/libpolycrypto/scripts/linux && \
#RUN pwd && ls &&\
#    cd libpolycrypto/scripts/linux && \
    bash install-libs.sh && \
    bash install-deps.sh && \
    ls && \
    pwd &&  \
    source /usr/src/libpolycrypto/libpolycrypto-docker/src/libpolycrypto/scripts/linux/set-env.sh release && \
    chmod 777 *&& \
    bash make.sh && \
    echo $PATH

VOLUME /usr/src/builds

ENV PATH="${PATH}:/usr/src/builds/polycrypto/master/release/libpolycrypto/bin/examples:/usr/src/builds/polycrypto/master/release/libpolycrypto/bin/app:/usr/src/builds/polycrypto/master/release/libpolycrypto/bin/bench:/usr/src/builds/polycrypto/master/release/libpolycrypto/bin/test:/usr/src/builds/polycrypto/master/release/libpolycrypto/bin:/usr/src/libpolycrypto/libpolycrypto-docker/src/libpolycrypto/scripts/linux"

# Define default command
CMD ["bash"]