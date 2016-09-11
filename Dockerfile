FROM alpine:3.4

RUN apk add --no-cache python

EXPOSE 53/udp

ADD dns*.py /
ADD entrypoint.sh /entrypoint.sh
ADD hosts /etc/docker-dns/hosts

ENTRYPOINT [ "/entrypoint.sh" ]
