FROM dunglas/frankenphp:latest

# Installer les extensions PHP nécessaires (Redis et PDO MySQL)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libhiredis-dev \
        libzip-dev \
        pkg-config \
        default-mysql-client; \
    docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        zip; \
    pecl install redis; \
    docker-php-ext-enable redis; \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
        libhiredis-dev \
        libzip-dev \
        pkg-config; \
    rm -rf /var/lib/apt/lists/*
