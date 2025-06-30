FROM debian:11.11

RUN apt update -y

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-curl \
    php-xml \
    php-mbstring \
    php-gd \
    php-cli \
    php-zip

RUN apt install curl -y

COPY ./tools/script.sh /
COPY ./tools/wp-config.php /

CMD ["/script.sh"]