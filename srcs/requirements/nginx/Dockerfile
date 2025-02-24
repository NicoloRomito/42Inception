# * Description: Nginx image -> latest tag is prohibited, so check every time the latest version
FROM alpine:3.21

RUN apk update && \
	apk add nginx openssl && \
	mkdir -p /run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]