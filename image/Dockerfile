FROM php:7.4-cli

# install-php-extensions
COPY assets/install-php-extensions /usr/local/bin/

# composer
RUN install-php-extensions @composer

# jq for converting json reports to gitlab's codequality format
RUN apt update && apt -y install jq

# phpcs, phpcbf
RUN composer global require squizlabs/php_codesniffer "^3.7.0"
RUN ln -nfs /root/.composer/vendor/bin/phpcs /usr/local/bin/
RUN ln -nfs /root/.composer/vendor/bin/phpcbf /usr/local/bin/

# phpstan
RUN composer global require phpstan/phpstan "^1.7.0"
RUN ln -nfs /root/.composer/vendor/bin/phpstan /usr/local/bin/

# psalm
RUN composer global require vimeo/psalm "^4.25.0"
RUN ln -nfs /root/.composer/vendor/bin/psalm /usr/local/bin/

COPY assets/scripts /root/scripts

COPY assets/docker-entrypoint.sh /

WORKDIR /app

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["true"]

