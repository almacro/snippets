FROM ubuntu:16.04

# env for doing meson & ninja builds

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y \
      python3 python3-pip build-essential ninja-build && \
    pip3 install --user meson

ENV PATH $PATH:/root/.local/bin




