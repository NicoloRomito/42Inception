# * Description: Nginx image -> latest tag is prohibited, so check every time the latest version
FROM debian:11.11

RUN apt -y update && apt install -y nginx && apt install openssl nginx -y

COPY ./tools/script.sh /script.sh

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]