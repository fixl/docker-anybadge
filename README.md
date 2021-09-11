# anybadge Image

[![pipeline status](https://gitlab.com/fixl/docker-anybadge/badges/master/pipeline.svg)](https://gitlab.com/fixl/docker-anybadge/-/commits/master)
[![version](https://fixl.gitlab.io/docker-anybadge/version.svg)](https://gitlab.com/fixl/docker-anybadge/-/commits/master)
[![size](https://fixl.gitlab.io/docker-anybadge/size.svg)](https://gitlab.com/fixl/docker-anybadge/-/commits/master)
[![Docker Pulls](https://img.shields.io/docker/pulls/fixl/anybadge)](https://hub.docker.com/r/fixl/anybadge)
[![Docker Pulls](https://img.shields.io/docker/stars/fixl/anybadge)](https://hub.docker.com/r/fixl/anybadge)

A Docker container containing [anybadge](https://github.com/jongracecox/anybadge) that can be used
along with [3 Musketeers](https://3musketeers.io/).


## Build the image

```bash
make build
```

## Inspect the image

```bash
docker inspect --format='{{ range $k, $v := .Config.Labels }}{{ printf "%s=%s\n" $k $v}}{{ end }}' anybadge:latest
```

## Generate badge

```bash
docker run --rm -v ${PWD}:/src anybadge \
    anybadge --value=$score --file=<badgeName>.svg <badgeLabel>
```

## Additional Scripts

**docker-size**

This script creates a label displaying the compressed size and layers inside the docker image.

> This interacts with the docker engine, so you may have to mount the docker socket

**docker-version**

This script derives the version from the tag of the image passed to the script. It does not verify
the image actually exists.
