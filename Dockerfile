#Based on https://github.com/kost/docker-alpine/tree/master/alpine-apache-php
FROM alpine:3.7

ADD ./root /

RUN apk add --update apache2 php7-apache2 && rm -f /var/cache/apk/* && \
chown -R apache:apache /app && \
chmod -R 755 /scripts

#Add code to redirect apache logs to /dev/stdout and /dev/stderr

EXPOSE 8000

WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]
