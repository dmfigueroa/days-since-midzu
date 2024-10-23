FROM tiredofit/nginx-php-fpm:8.3-debian-bookworm AS base

# Set extension flags to true to allow them to be enabled
ENV PHP_ENABLE_IGBINARY=TRUE
ENV PHP_ENABLE_MSGPACK=TRUE
ENV PHP_ENABLE_REDIS=TRUE
ENV PHP_ENABLE_OPENSSL=FALSE
ENV PHP_ENABLE_PDO_SQLITE=TRUE
ENV PHP_ENABLE_SQLITE3=TRUE

# Enable PHP extensions
RUN php-ext enable igbinary \
    && php-ext enable msgpack \
    && php-ext enable redis \
    && php-ext enable posix \
    && php-ext enable zip \
    && php-ext enable pdo_sqlite \
    && php-ext sqlite3

# Install JavaScript dependencies
ARG NODE_VERSION=20.18.0
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    # Corepack will install yarn automatically according to my package.json
    corepack enable && \
    rm -rf /tmp/node-build-master


FROM base

# Copy the app files...
COPY . /www/html

# Move to workdir
WORKDIR /www/html

# Expose service
EXPOSE 8080

# Re-run install, but now with scripts and optimizing the autoloader (should be faster)...
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Precompiling assets for production
RUN yarn install --immutable && \
    yarn build && \
    rm -rf node_modules

# Grant executable permission to entrypoint
RUN ["chmod", "+x", "/www/html/start-docker.sh"]

# Execute entrypoint
ENTRYPOINT ["/www/html/start-docker.sh"]
