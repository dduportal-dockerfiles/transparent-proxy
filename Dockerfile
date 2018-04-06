FROM alpine:3.7

LABEL Maintainer="Damien DUPORTAL <damien.duportal@gmail.com>"

RUN apk add --no-cache \
  bash \
  curl \
  ca-certificates \
  gettext \
  iptables \
  redsocks \
  tini

COPY redsocks.tmpl /etc/redsocks.tmpl
COPY whitelist.txt /etc/redsocks-whitelist.txt
COPY redsocks.sh /usr/local/bin/redsocks.sh
COPY redsocks-fw.sh /usr/local/bin/redsocks-fw.sh

VOLUME ["/etc/redsocks"]

ENTRYPOINT ["/sbin/tini","-g","--","bash","/usr/local/bin/redsocks.sh"]
