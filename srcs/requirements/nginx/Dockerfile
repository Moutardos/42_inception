FROM debian:bookworm

ARG SSL_DIR
ARG WWW_DIR

RUN apt-get update && \
	apt-get install -y \
		nginx \
		openssl

RUN mkdir -p /etc/nginx/ssl/

RUN  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lcozdenm.42.fr/UID=login"

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
