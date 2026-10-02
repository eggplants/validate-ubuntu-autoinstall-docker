FROM ubuntu:resolute@sha256:3595d7fc4286a33fad0fd853a4063e654287a9c3787437d7937c94ca3f7a804e

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
