ARG DOCKER_REGISTRY

FROM ${DOCKER_REGISTRY:+${DOCKER_REGISTRY}/}alpine

COPY --from=gcr.io/kaniko-project/executor:debug /kaniko /kaniko

RUN \
  apk add --update --no-cache \
    curl \
    git \
    jq \
    yq

RUN mkdir -p /kaniko/.docker

WORKDIR /var/workspace
