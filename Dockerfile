FROM ubuntu:resolute@sha256:678c6550cc43645e08669028bc177f50be4e7c5b8cca677067b1914d4afc7a03

RUN \
  apt-get update && \
  apt-get install -y git make && \
  git clone https://github.com/canonical/subiquity.git --single-branch --depth 1 -b 26.04

WORKDIR /subiquity

RUN \
  sed -i 's/sudo //' Makefile && \
  sed -i \
    -e '/^import os$/a import zoneinfo' \
    -e '/^    if not active_timedatectl():$/,/^        return special_keys$/d' \
    -e '/^    tzcmd = \["timedatectl", "list-timezones"\]$/d' \
    -e '/^    list_tz_out = subprocess\.check_output(tzcmd/d' \
    -e 's/^    real_tzs = list_tz_out\.splitlines()$/    real_tzs = sorted(zoneinfo.available_timezones())/' \
    subiquity/server/controllers/timezone.py && \
  make install_deps && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./scripts/validate-autoinstall-user-data.py"]
