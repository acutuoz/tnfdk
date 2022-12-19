FROM alpine:latest
RUN apk --no-cache add --no-cache wget
RUN cd /var/www/html && \
    wget https://github.com/prasathmani/tinyfilemanager/archive/refs/tags/2.5.0.zip -O tiny.zip && \
    unzip tiny.zip -d tiny/ && \
    rm tiny.zip && \
    mv tiny/tinyfilemanager.php tiny/index.php && \
    sed -i "s/\$root_path =.*;/\$root_path = \$_SERVER['DOCUMENT_ROOT'];/g" tiny/index.php


FROM php:7.4-apache
RUN chown -R www-data:www-data /var/www
EXPOSE 80
