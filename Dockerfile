FROM php:7.4-apache

RUN apt-get update
RUN apt-get install --yes --force-yes unzip wget cron g++ gettext libicu-dev openssl libc-client-dev libkrb5-dev libxml2-dev libfreetype6-dev libgd-dev libmcrypt-dev bzip2 libbz2-dev libtidy-dev libcurl4-openssl-dev libz-dev libmemcached-dev libxslt-dev

RUN a2enmod rewrite

RUN docker-php-ext-install mysqli 
RUN docker-php-ext-enable mysqli

RUN docker-php-ext-configure gd --with-freetype=/usr --with-jpeg=/usr
RUN docker-php-ext-install gd

RUN cd /var/www/html && \
    wget https://github.com/prasathmani/tinyfilemanager/archive/refs/tags/2.5.0.zip -O tiny.zip && \
    unzip tiny.zip && \
    rm tiny.zip && \
    mv tinyfilemanager-2.5.0 tiny && \
    mv tiny/tinyfilemanager.php tiny/index.php && \
    sed -i "s/\$root_path =.*;/\$root_path = \$_SERVER['DOCUMENT_ROOT'];/g" tiny/index.php && \
    sed -i "s/\$exclude_items = array();/\$exclude_items = ['tiny'];/g" tiny/index.php

RUN chown -R www-data:www-data /var/www
EXPOSE 80
