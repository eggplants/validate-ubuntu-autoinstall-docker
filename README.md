# validate-ubuntu-autoinstall-docker

Validate Ubuntu Server Autoinstall Configuration on Docker

## Reference

<https://canonical-subiquity.readthedocs-hosted.com/en/latest/howto/autoinstall-validation.html>

## Build

```bash
docker build -t validate-ubuntu-autoinstall .
```

## Use

```bash
# show help
docker run --rm -it validate-ubuntu-autoinstall -h

# validate from file
docker run --rm -it -v path/to/autoinstall.yaml:/autoinstall.yaml validate-ubuntu-autoinstall /autoinstall.yaml

# validate from stdin
cat autoinstall.yaml | docker run --rm -i -a stdin -a stderr -a stdout validate-ubuntu-autoinstall
```
