FROM debian:bookworm

ARG SSL_DIR
ARG WWW_DIR

RUN apt-get update && \
	apt-get install -y \
		nginx \
		openssl

RUN mkdir -p  /etc/nginx/ssl/ \
	&& mkdir -p ${WWW_DIR} \
	&& chmod -R g+w  ${WWW_DIR}\
	&& chown -R www-data:www-data ${WWW_DIR}

VOLUME ${WWW_DIR}

RUN ln -sf /dev/sdout /var/log/nginx/access.log \
	&& ln -sf /dev/sdout /var/log/nginx/error.log
RUN  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout  /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lcozdenm.42.fr/UID=login"

RUN chown -R www-data:www-data /etc/nginx/ssl/ \
	&& chmod -R 550 /etc/nginx/ssl/

COPY nginx.conf /etc/nginx/nginx.conf
RUN ls -al /etc/nginx/ssl/inception.*
RUN cat /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
