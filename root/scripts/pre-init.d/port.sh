#!/bin/sh
sed -i "s#Listen .*#Listen ${PORT}#g" /etc/apache2/httpd.conf
