ARG DOCKER_REGISTRY

FROM ${DOCKER_REGISTRY:+${DOCKER_REGISTRY}/}alpine

COPY --from=gcr.io/kaniko-project/executor:debug /kaniko/executor /kaniko/executor

RUN \
  apk add --update --no-cache \
    curl \
    git \
    jq \
    yq

RUN mkdir -p /kaniko/.docker

ARG CONTAINER_USER=default
ARG CONTAINER_USER_GROUP=default

RUN addgroup -S ${CONTAINER_USER_GROUP} \
  && adduser -S ${CONTAINER_USER} -G ${CONTAINER_USER_GROUP}

USER ${CONTAINER_USER}:${CONTAINER_USER_GROUP}

WORKDIR /var/workspace