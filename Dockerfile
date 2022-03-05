FROM python:3.10-alpine

ARG ANYBADGE_VERSION

RUN apk add --no-cache \
        make \
        bash \
        coreutils \
        docker-cli \
    && pip install --no-cache-dir anybadge==${ANYBADGE_VERSION}

COPY scripts/docker-size.sh /usr/local/bin/docker-size
COPY scripts/docker-version.sh /usr/local/bin/docker-version

RUN chmod +x /usr/local/bin/docker-size \
    && chmod +x /usr/local/bin/docker-version

WORKDIR /src

CMD ["anybadge"]
