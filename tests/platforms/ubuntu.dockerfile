# syntax=docker/dockerfile:1

ARG BASE_IMAGE_VERSION=latest

FROM ubuntu:${BASE_IMAGE_VERSION}

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

RUN <<-"EOF"
  group=$(getent group ${DOCKER_USER_GID} 2>/dev/null | cut -d: -f1)
  if [ -n "${group}" ]; then
    groupmod --new-name ${DOCKER_USER_GROUP} ${group}
  else
    groupadd -o --gid ${DOCKER_USER_GID} ${DOCKER_USER_GROUP}
  fi

  user=$(getent passwd ${DOCKER_USER_UID} 2>/dev/null | cut -d: -f1)
  if [ -n "${user}" ]; then
    usermod -o -d /home/${DOCKER_USER_NAME}  -s /bin/bash -u ${DOCKER_USER_UID} -l ${DOCKER_USER_NAME} ${user}
  else
    useradd -m -s /bin/bash -u ${DOCKER_USER_UID} -g ${DOCKER_USER_GID} ${DOCKER_USER_NAME}
  fi
EOF

USER ${DOCKER_USER_NAME}

COPY . /home/${DOCKER_USER_NAME}/dotfiles
WORKDIR /home/${DOCKER_USER_NAME}/dotfiles
