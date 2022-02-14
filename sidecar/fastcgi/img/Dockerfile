# Base Runtime
FROM php:8.0-fpm

# Install the needed system dependencies. Dependencies are not pinned to a specific version
# trunk-ignore(hadolint/DL3008)
RUN \
  apt-get update && \
  apt-get install --no-install-recommends -y apt-utils aspell-de aspell-en curl firebird-dev libc-client-dev libcurl3-dev libcurl4 libfreetype6-dev libicu-dev libjpeg62-turbo-dev libkrb5-dev libldap2-dev libldb-dev libmcrypt-dev libonig-dev libpng-dev libpq-dev libpspell-dev librecode-dev librecode0 libsnmp-dev libsqlite3-0 libsqlite3-dev libssl-dev libtidy-dev libxml2-dev libxml2-dev libxslt-dev libzip-dev mariadb-client postgresql-client && \
  rm -rf /var/lib/apt/lists/*
RUN apt-get autoremove -y && apt-get clean autoclean

# docker-php-ext-install.
RUN docker-php-ext-install -j4 \
  bcmath \
  curl \
  gd \
  mbstring \
  mysqli \
  pdo \
  pdo_mysql \
  pdo_pgsql \
  pgsql \
  zip

# Install Composer for PHP.
# trunk-ignore(hadolint/DL4006)
RUN curl -sS 'https://getcomposer.org/installer' | php -- --install-dir='/usr/bin/' --filename=composer

# Install the container launch script.
COPY './scripts/init.sh' '/init.sh'

# Set the entrypoint to the launch script above for container boot.
ENTRYPOINT ["/bin/sh", "/init.sh"]
