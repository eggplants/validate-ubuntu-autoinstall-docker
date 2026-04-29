FROM ubuntu:resolute@sha256:5e275723f82c67e387ba9e3c24baa0abdcb268917f276a0561c97bef9450d0b4

RUN \
  apt-get update && \
  apt-get install -y git make && \
  git clone https://github.com/canonical/subiquity.git --single-branch --depth 1 -b 26.04

WORKDIR /subiquity

RUN \
  sed -i 's/sudo //' Makefile && \
  make install_deps && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./scripts/validate-autoinstall-user-data.py"]
