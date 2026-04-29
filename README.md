# validate-ubuntu-autoinstall-docker

[![release](
  <https://github.com/eggplants/validate-ubuntu-autoinstall-docker/actions/workflows/release.yml/badge.svg>
)](
  <https://github.com/eggplants/validate-ubuntu-autoinstall-docker/actions/workflows/release.yml>
) [![ghcr latest](
  <https://ghcr-badge.egpl.dev/eggplants/validate-ubuntu-autoinstall-docker/latest_tag?trim=major&label=latest>
 ) ![ghcr size](
  <https://ghcr-badge.egpl.dev/eggplants/validate-ubuntu-autoinstall-docker/size>
)](
  <https://github.com/eggplants/validate-ubuntu-autoinstall-docker/pkgs/container/validate-ubuntu-autoinstall-docker>
)

Validate Ubuntu Server Autoinstall Configuration on Docker

## Reference

<https://canonical-subiquity.readthedocs-hosted.com/en/latest/howto/autoinstall-validation.html>

## Install

```bash
# build in local
docker build -t validate-ubuntu-autoinstall .

# pull from ghcr
docker pull ghcr.io/eggplants/validate-ubuntu-autoinstall-docker
docker tag ghcr.io/eggplants/validate-ubuntu-autoinstall-docker validate-ubuntu-autoinstall
```

## Use

```bash
# show help
docker run --rm -it validate-ubuntu-autoinstall -h

# validate from file
docker run --rm -it -v path/to/autoinstall.yaml:/autoinstall.yaml validate-ubuntu-autoinstall /autoinstall.yaml

# validate from stdin
cat autoinstall.yaml | docker run --rm -i validate-ubuntu-autoinstall
```
