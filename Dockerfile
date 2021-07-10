FROM php:7.4-fpm-alpine

WORKDIR /srv/www/

RUN apk add --no-cache \
      freetype \
      libjpeg-turbo \
      libpng \
      freetype-dev \
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
      php7-exif

RUN docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure gd \
      --with-freetype=/usr/include/ \
      --with-jpeg=/usr/include/ \
      --with-webp=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable gd \
    && apk del --no-cache \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev

RUN docker-php-ext-install \
      exif \
      pdo \
      bcmath \
      pdo_mysql \
      zip \
      intl \
      iconv \
      pcntl \

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN rm -rf /tmp/*
