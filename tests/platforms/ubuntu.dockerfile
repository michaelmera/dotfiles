FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends bats && \
    apt-get purge -y

COPY . /root/dotfiles
WORKDIR /root/dotfiles
