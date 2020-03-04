# Pull base image.
FROM ubuntu:16.04

# Define workdir
WORKDIR /root

# Install some tools: gcc build tools, unzip, etc
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential unzip cmake git libgmp3-dev libssl-dev sudo binfmt-support clang clang-3.8 file libclang-common-3.8-dev libclang1-3.8 libffi-dev libllvm3.8 libmagic1 libobjc-5-dev libobjc4 libpipeline1 libpython-stdlib libpython2.7-minimal libpython2.7-stdlib libtinfo-dev llvm-3.8 llvm-3.8-dev llvm-3.8-runtime mime-support python python-minimal python2.7 python2.7-minimal


RUN cd /usr/src/ && \
    mkdir libpolycrypto && \
    cd libpolycrypto

WORKDIR /usr/src/libpolycrypto

RUN git clone https://github.com/tyurek/libpolycrypto-docker.git && \
    pwd && \
    ls && \
    cd libpolycrypto-docker/src/libpolycrypto/scripts/linux && \
    bash install-libs.sh && \
    bash install-deps.sh && \
    bash set-env.sh release
    #bash make.sh


# Define default command
CMD ["bash"]