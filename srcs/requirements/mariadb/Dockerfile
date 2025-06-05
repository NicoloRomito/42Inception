FROM debian:11.11

RUN apt-get update -y && apt-get install maria-db-server -y

COPY ./tools/server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/script.sh /

CMD ["/script.sh"]
