FROM miguelpeixe/s6-base

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    make \
    git \
    gcc \
    g++ \
    default-libmysqlclient-dev && \
  rm -rf /var/lib/apt/lists/*

RUN \
  git clone https://github.com/Sphereserver/Source.git /etc/sphere && \
  cd /etc/sphere && \
  make NIGHTLY=1

RUN \
  git clone https://github.com/Sphereserver/Scripts.git /scripts

COPY rootfs/ /

EXPOSE 2593
