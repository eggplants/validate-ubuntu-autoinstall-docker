FROM ubuntu:resolute@sha256:f144425ff09be612d6d9ad965196e9cdc23dae1f42110a8a11a3e9a8198759f7

RUN \
  apt-get update && \
  apt-get install -y git make && \
  git clone https://github.com/canonical/subiquity.git --single-branch --depth 1 -b 26.10

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
