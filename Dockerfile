FROM python:3.7-alpine

ARG ANYBADGE_VERSION

RUN apk add --no-cache \
        make \
        bash \
    && pip install --no-cache-dir anybadge==${ANYBADGE_VERSION}

WORKDIR /src

CMD ["anybadge"]

# Values change frequently. Put last to preserve build cache.
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG PIPELINE

LABEL maintainer="@fixl" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.version="${ANYBADGE_VERSION}" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.vcs-url="${VCS_URL}" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.gitlab.pipeline-url="${PIPELINE}"
