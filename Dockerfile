FROM python:3.9-alpine

ARG ANYBADGE_VERSION

RUN apk add --no-cache \
        make \
        bash \
        coreutils \
        docker-cli \
    && pip install --no-cache-dir anybadge==${ANYBADGE_VERSION} \
    # Fixes expat < 2.4.4 CVEs: CVE-2022-23852, CVE-2022-23990
    && apk upgrade --no-cache expat

COPY scripts/docker-size.sh /usr/local/bin/docker-size
COPY scripts/docker-version.sh /usr/local/bin/docker-version

RUN chmod +x /usr/local/bin/docker-size \
    && chmod +x /usr/local/bin/docker-version

WORKDIR /src

CMD ["anybadge"]
