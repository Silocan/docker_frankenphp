# syntax=docker/dockerfile:1

FROM dunglas/frankenphp:1-php8.2

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_NO_INTERACTION=1 \
    XDEBUG_MODE=off

# curl, pdo et xml sont déjà compilés dans l'image. install-php-extensions
# installe les libs -dev et les retire tout seul.
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends default-mysql-client; \
    install-php-extensions \
        bcmath \
        calendar \
        gd \
        intl \
        ldap \
        mongodb-1.15.1 \
        mysqli \
        opcache \
        pdo_mysql \
        redis \
        soap \
        sockets \
        xdebug \
        zip
