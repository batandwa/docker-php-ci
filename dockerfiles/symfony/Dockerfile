# FROM phpmentors/symfony-app
FROM php:5.6-apache

# PHP extensions
RUN apt-get update \
    && apt-get install -y libmcrypt-dev zlib1g-dev git
RUN docker-php-ext-install iconv mcrypt mbstring pdo pdo_mysql zip \
    && rm -rf /var/lib/apt/lists/*

# Install Grunt
RUN apt-get install --yes curl \
    && curl --silent --location https://deb.nodesource.com/setup_4.x | bash - \
    && apt-get install --yes nodejs build-essential \
    && npm install -g grunt-cli

# Install SASS
RUN apt-get install --yes ruby \
    && gem install sass
# RUN mkdir /var/log/mysql -p \
#     && touch /var/log/mysql/mysql_queries.log \
#     && chown mysql:mysql /var/log/mysql/ -Rf
# RUN a2enmod rewrite \
#     && (crontab -l ; echo "*  *  *  *  *  /var/app/console phpci:run-builds") | crontab
RUN a2enmod rewrite

# docker-compose restart

# RUN bash -c '/var/app/composer.phar --ignore-platform-reqs install' \
#     && bash -c '/var/app/composer.phar --ignore-platform-reqs update' \
#     && chown www-data:www-data /var/app -Rf
#     && mv /var/app/PHPCI/config.yml /var/app/PHPCI/config.yml.`date +%Y%m%d%H%M%S` \
#     && bash -c 'cd /var/app && ./console phpci:install --url=http://$VIRTUAL_HOST --db-host=db --db-name=phpci --db-user=root --db-pass=doinkydoinkwalking --admin-name=admin --admin-pass=doinkydoinkwalking --admin-mail=admin@batandwa.me --no-ansi --no-interaction' \
#     && touch /var/.build-tool-set-up

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Download and install Invoce Ninja

ENV PHPCI_VERSION 1.6.0
# ENV PHPCI_VERSION 2.4.6
#ENV INVOICENINJA_SHA1 3e9b63c1681b6923dc1a24399411c1abde6ef5ea

RUN curl -o phpci.tar.gz -SL https://github.com/Block8/PHPCI/archive/${PHPCI_VERSION}.tar.gz \
    && mkdir -p /var/app/ \
    && tar -xzf phpci.tar.gz -C /tmp/ \
    && rm phpci.tar.gz \
    && rm -R /var/app \
    && mv /tmp/PHPCI-${PHPCI_VERSION} /var/app \
    && chown -R www-data:www-data /var/app \
    && cp /var/app/public/.htaccess.dist /var/app/public/.htaccess \
    && composer install --working-dir /var/app -o --no-dev --no-interaction
    # && mv /var/app/PHPCI/config.yml /var/app/PHPCI/config.yml.`date +%Y%m%d%H%M%S` \
    # RUN /var/app/console phpci:install --url=http://$PHPCI_HOST --db-host=db --db-name=$DB_ENV_MYSQL_DATABASE --db-user=$DB_ENV_MYSQL_USER --db-pass=$DB_ENV_MYSQL_PASSWORD --admin-name=admin --admin-pass=admin --admin-mail=admin@batandwa.me --no-ansi --no-interaction


    # DB_ENV_MYSQL_DATABASE  =phpci
    # DB_ENV_MYSQL_PASSWORD  =doindfdc6cb0bk
    # DB_ENV_MYSQL_ROOT_PASSWORD  =f56065f7c8e3
    # DB_ENV_MYSQL_USER  =phpci

# RUN curl -o phpci.tar.gz -SL https://github.com/hillelcoren/invoice-ninja/archive/v${PHPCI_VERSION}.tar.gz \
# #    && echo "$INVOICENINJA_SHA1 *phpci.tar.gz" | sha1sum -c - \
#     && tar -xzf phpci.tar.gz -C /var/app/ \
#     && rm phpci.tar.gz \
#     && mv /var/app/invoiceninja-${PHPCI_VERSION} /var/app \
#     && chown -R www-data:www-data /var/app \
#     && composer install --working-dir /var/app -o --no-dev --no-interaction

RUN a2ensite 000-default

######
# DEFAULT ENV
######
ENV APACHE_LOG_DIR /var/log/apache2
# ENV DB_HOST mysql
# ENV DB_DATABASE ninja
# ENV APP_KEY SomeRandomString
# ENV LOG errorlog
# ENV APP_DEBUG 0


#use to be mounted into nginx for exemple
VOLUME /var/app/public

WORKDIR /var/app

EXPOSE 80

# COPY app-entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh

# ENTRYPOINT ["/entrypoint.sh"]
# CMD ["php-fpm"]
