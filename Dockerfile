#Based on https://github.com/kost/docker-alpine/tree/master/alpine-apache-php
FROM alpine:3.7

ADD ./root /

RUN apk add --update apache2 php7-apache2 php7-openssl && rm -f /var/cache/apk/* && \
mkdir -p /run/apache2/ && \
chown -R apache:apache /app /var/log/apache2 /run/apache2/ /dev/stdout /dev/stderr && \
chmod -R 755 /scripts && \
sed -i 's#Listen 80#Listen 8000#g' /etc/apache2/httpd.conf && \
sed -i 's#ServerTokens .*#ServerTokens Prod#g' /etc/apache2/httpd.conf && \
sed -i 's#ServerSignature .*#ServerSignature Off#g' /etc/apache2/httpd.conf && \
sed -i 's#DocumentRoot ".*#DocumentRoot "/app"#g' /etc/apache2/httpd.conf && \
sed -i 's#<Directory ".*#<Directory "/app">#g' /etc/apache2/httpd.conf && \
sed -i 's#Options Indexes FollowSymLinks#Options FollowSymLinks#g' /etc/apache2/httpd.conf && \
sed -i 's#AllowOverride None#AllowOverride All#g' /etc/apache2/httpd.conf && \
sed -i 's#ErrorLog logs/error.log#ErrorLog /dev/stderr#g' /etc/apache2/httpd.conf && \
sed -i 's#CustomLog logs/access.log combined#CustomLog /dev/stdout combined#g' /etc/apache2/httpd.conf && \
sed -i 's|#LoadModule rewrite_module modules/mod_rewrite.so|LoadModule rewrite_module modules/mod_rewrite.so|g' /etc/apache2/httpd.conf

EXPOSE 8000

WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]
CMD ["httpd", "-DFOREGROUND"]
