# Pull base image.
FROM ubuntu:16.04

# Define workdir
WORKDIR /root

# Install some tools: gcc build tools, unzip, etc
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential unzip cmake git


RUN cd /usr/src/ && \
    mkdir libpolycrypto && \
    cd libpolycrypto

WORKDIR /usr/src/libpolycrypto

RUN git clone https://github.com/alinush/libpolycrypto.git && \
    pwd && \
    ls && \
    bash libpolycrypto/scripts/linux/install-libs.sh && \
    bash libpolycrypto/scripts/linux/install-deps.sh


# Define default command
CMD ["bash"]