FROM ubuntu:18.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG PRITUNL_VERSION=1.29.2051.18-0ubuntu1~bionic

RUN \
    apt-get update && apt-get -y upgrade && apt-get -y install gnupg2 && \
    echo "deb http://repo.pritunl.com/stable/apt bionic main" > /etc/apt/sources.list.d/pritunl.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
    \
    apt-get update && \
    apt-get -y install pritunl=${PRITUNL_VERSION} iptables && \
    \
    apt-get clean && \
    apt-get -y -q autoclean && \
    apt-get -y -q autoremove && \
    rm -rf /tmp/*

VOLUME /var/lib/pritunl

COPY entrypoint.sh /bin/entrypoint

ENTRYPOINT ["/bin/entrypoint"]

CMD ["/usr/bin/pritunl", "start", "-c", "/etc/pritunl.conf"]
