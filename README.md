# anybadge Image 

[![](https://images.microbadger.com/badges/image/fixl/anybadge.svg)](https://microbadger.com/images/fixl/anybadge "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/fixl/anybadge.svg)](https://microbadger.com/images/fixl/anybadge "Get your own version badge on microbadger.com")

A Docker container containing [anybadge](https://github.com/jongracecox/anybadge) that can be used
along with [3 Musketeers](https://3musketeers.io/).


## Build the image

```bash
make build
```

## Generate badge

```bash
docker run --rm -v ${PWD}:/src anybadge \
    anybadge --value=$score --file=<badgeName>.svg <badgeLabel>
```
