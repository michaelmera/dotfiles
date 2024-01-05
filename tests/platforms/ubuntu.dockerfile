FROM ubuntu:22.04

ARG DOCKER_USER_UID=1000
ARG DOCKER_USER_GID=1000
ARG DOCKER_USER_NAME
ARG DOCKER_USER_GROUP

ENV DEBIAN_FRONTEND=noninteractive

RUN test -n "${DOCKER_USER_NAME}"  || (echo "DOCKER_USER_NAME is not set"  && false)
RUN test -n "${DOCKER_USER_GROUP}" || (echo "DOCKER_USER_GROUP is not set" && false)

RUN apt-get update && \
    apt-get install -y --no-install-recommends bats && \
    apt-get purge -y

RUN groupadd --gid ${DOCKER_USER_GID} ${DOCKER_USER_GROUP}
RUN useradd -m -s /bin/bash --uid ${DOCKER_USER_UID} --gid ${DOCKER_USER_GID} ${DOCKER_USER_NAME}

USER ${DOCKER_USER_NAME}

COPY . /home/${DOCKER_USER_NAME}/dotfiles
WORKDIR /home/${DOCKER_USER_NAME}/dotfiles
