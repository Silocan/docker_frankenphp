FROM dunglas/frankenphp:php8.3

# Composer 
RUN set -ex; \     
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \     
    chmod +x /usr/local/bin/composer

RUN install-php-extensions bcmath calendar curl intl ldap mysqli pdo pdo_mysql gd mongodb-1.15.1 redis soap xdebug xml zip;


# Installer les extensions PHP nécessaires (Redis et PDO MySQL)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libhiredis-dev \
        libzip-dev \
        pkg-config \
        default-mysql-client \
        curl; \
    curl -sSLf -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions; \
    install-php-extensions \
        bcmath calendar curl intl ldap mysqli mongodb pdo pdo_mysql gd redis soap sockets xdebug xml zip; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
        libhiredis-dev \
        libzip-dev \
        pkg-config; \
    rm -rf /var/lib/apt/lists/*; \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer; \     
    chmod +x /usr/local/bin/composer

WORKDIR /var/www 
#
#docker-php-ext-install -j$(nproc) \
#bcmath calendar curl intl ldap mysqli pdo pdo_mysql gd redis soap xdebug xml zip; \
#pecl install redis mongodb; \