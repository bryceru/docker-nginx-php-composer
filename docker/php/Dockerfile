FROM php:7.4-fpm-alpine

WORKDIR /srv/www/

RUN echo ${PHP_MEMORY_LIMIT}

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

RUN docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure gd \
      --with-freetype=/usr/include/ \
      --with-jpeg=/usr/include/ \
      --with-webp=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable gd

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

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && docker-php-ext-enable xdebug

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD opcache.ini "$PHP_INI_DIR/conf.d/opcache.ini"
ADD php.ini "$PHP_INI_DIR/conf.d/99-php.over.ini"

RUN apk del --no-cache autoconf \
#     freetype-dev \
#     libjpeg-turbo-dev \
#     libpng-dev \
#     libwebp-dev \
#     freetype-dev \
     libzip-dev \
     icu-dev \
     libmcrypt-dev \
     zlib-dev \
     build-base

RUN rm -rf /tmp/*

CMD ["php-fpm"]
