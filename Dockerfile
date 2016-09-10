FROM alpine:3.4

RUN apk add --no-cache python

ADD dns*.py /
ADD hosts /etc/docker-dns/hosts

EXPOSE 53/udp
VOLUME /etc/docker-dns

ENTRYPOINT [ "/entrypoint.sh" ]
