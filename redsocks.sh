#!/bin/bash
# Entrypoint script for Redsocks
set -eux -o -pipefail

proxy_ip="${1}"
proxy_port="${2}"
no_proxy_pattern="${3:localhost}"
redsocks_conf=/etc/redsocks/main.conf

HTTP_PROXY="http://${proxy_ip}:${proxy_port}/"
HTTPS_PROXY="${HTTP_PROXY}"
FTP_PROXY="${HTTP_PROXY}"
NO_PROXY="${no_proxy_pattern}"
http_proxy="${HTTP_PROXY}"
https_proxy="${HTTP_PROXY}"
ftp_proxy="${HTTP_PROXY}"
no_proxy="${no_proxy_pattern}"

export HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY
export http_proxy https_proxy ftp_proxy no_proxy
export proxy_ip proxy_port

echo "== Generating redsocks configuration file ..."

envsubst '${proxy_ip},${proxy_port}' \
 < /etc/redsocks.tmpl \
 > "${redsocks_conf}"

echo "== Generated configuration:"
cat "${redsocks_conf}"

echo "== Setting Up Signal Catching"
trap trapper HUP INT QUIT TERM

trapper() {
  echo "== Signal catched. Disabling iptables rules..."
  exec /usr/local/bin/redsocks-fw.sh stop
}

echo "== Activating iptables rules..."
/usr/local/bin/redsocks-fw.sh start

echo "== Starting redsocks..."
exec /usr/bin/redsocks -c "${redsocks_conf}"
