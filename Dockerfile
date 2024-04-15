ARG KANIKO_IMAGE=gcr.io/kaniko-project/executor

FROM ${KANIKO_IMAGE} as kaniko

ARG DOCKER_REGISTRY

FROM ${DOCKER_REGISTRY:+${DOCKER_REGISTRY}/}alpine

COPY --from=kaniko /etc/nsswitch.conf /etc/nsswitch.conf
COPY --from=kaniko /kaniko /kaniko

ENV \
  DOCKER_CONFIG=/kaniko/.docker/ \
  DOCKER_CREDENTIAL_GCR_CONFIG=/kaniko/.config/gcloud/docker_credential_gcr_config.json \
  SSL_CERT_DIR=/kaniko/ssl/certs \
  USER=root

RUN \
  apk add --update --no-cache \
    curl \
    git \
    jq \
    yq

WORKDIR /var/workspace
