FROM python:3.7-alpine

LABEL maintainer "@fixl"

ARG ANYBADGE_VERSION

RUN apk add --no-cache \
        make \
        bash \
    && pip install --no-cache-dir anybadge==${ANYBADGE_VERSION}

WORKDIR /src

CMD ["anybadge"]
