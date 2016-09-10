#!/bin/sh

EXTERNAL_DNS=${EXTERNAL_DNS:-8.8.8.8}
HOSTS_FILE=${HOSTS_FILE:-/etc/docker-dns/hosts}
PORT=${PORT:-53}

python /dnsproxy.py -f ${HOSTS_FILE} -H 0.0.0.0 -p ${PORT} -s ${EXTERNAL_DNS}
