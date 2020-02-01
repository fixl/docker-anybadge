FROM python:3.7-alpine

ARG ANYBADGE_VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="@fixl" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.version="${ANYBADGE_VERSION}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-url="https://gitlab.com/fixl/docker-anybadge" \
      org.label-schema.vcs-ref="${VCS_REF}"

RUN apk add --no-cache \
        make \
        bash \
    && pip install --no-cache-dir anybadge==${ANYBADGE_VERSION}

WORKDIR /src

CMD ["anybadge"]
