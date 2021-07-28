FROM php:7.4-fpm-alpine

WORKDIR /srv/www/

RUN apk add --no-cache \
      autoconf \
      freetype \
      libjpeg-turbo \
      libpng \
      libjpeg-turbo-dev \
      libpng-dev \
      xvfb \
      wget \
      zip unzip \
      acl \
      libwebp-dev \
      ttf-freefont \
      fontconfig \
      openssh-client \
      libzip-dev \
      ssmtp \
      freetype-dev \
      freetype \
      libpng \
      icu-dev \
      libmcrypt-dev \
      libmcrypt \
      libldap \
      zlib-dev \
      libzip \
      php7-exif \
      build-base

RUN cp "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN docker-php-ext-configure intl && \
    docker-php-ext-configure gd \
      --with-freetype=/usr/include/ \
      --with-jpeg=/usr/include/ \
      --with-webp=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install \
      exif \
      pdo \
      bcmath \
      pdo_mysql \
      zip \
      intl \
      iconv \
      pcntl \
      opcache

RUN docker-php-ext-enable gd intl

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && docker-php-ext-enable xdebug

RUN pecl install apcu && docker-php-ext-enable apcu

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD php.ini "$PHP_INI_DIR/conf.d/99-php.over.ini"

RUN sed -i -e '/\[www\]/ { N; /.*/ { s||[www]\nlisten = /var/run/php7-fpm.sock\nlisten.mode = 0666| }}' /usr/local/etc/php-fpm.d/zz-docker.conf

RUN apk del --no-cache autoconf \
     libzip-dev \
     icu-dev \
     libmcrypt-dev \
     zlib-dev \
     build-base

RUN rm -rf /tmp/*

CMD ["php-fpm"]
