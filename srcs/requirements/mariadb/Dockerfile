FROM alpine:3.21

RUN apk update && \
    apk add --no-cache \
    mariadb mariadb-client

COPY ./tools/server.cnf /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
