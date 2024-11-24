ARG ALPINE_VERSION=3.12
ARG OFELIA_VERSION=0.3.13

FROM mcuadros/ofelia:${OFELIA_VERSION} AS ofelia

FROM alpine:${ALPINE_VERSION}

ARG GO_TASK_VERSION=3.40.0
ARG RUNITOR_VERSION=1.3.0-build.4

LABEL ofelia.service=true
LABEL ofelia.enabled=true

COPY --from=ofelia /usr/bin/ofelia /usr/bin/ofelia

RUN <<EOF
apk add --no-cache \
    bash \
    wget \
    jq \
    tzdata \
    ca-certificates
apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    docker-cli docker-cli-compose

wget https://github.com/go-task/task/releases/download/v${GO_TASK_VERSION}/task_linux_amd64.tar.gz -O /tmp/task.tar.gz
tar -xzf /tmp/task.tar.gz -C /usr/bin task
rm /tmp/task.tar.gz

wget https://github.com/bdd/runitor/releases/download/v${RUNITOR_VERSION}/runitor-v${RUNITOR_VERSION}-linux-amd64 -O /usr/bin/runitor

EOF

VOLUME [ "/tasks" ]
VOLUME [ "/config" ]

ENTRYPOINT ["/usr/bin/ofelia"]

CMD ["daemon", "--docker", "--config", "/config/config.ini"]
