FROM debian:bookworm

ARG SSL_DIR
ARG WWW_DIR
ARG SERVER_NAME

RUN apt-get update && \
	apt-get install -y \
		php-fpm \
		php-mysql \
		curl \
		tar \
		mariadb-client

RUN mkdir -p ${WWW_DIR} \
		&& chmod -R g+w  ${WWW_DIR}\
		&& chown -R www-data:www-data ${WWW_DIR}

VOLUME ${WWW_DIR}

COPY www.conf /etc/php/8.2/fpm/pool.d/www.conf 

COPY wp_script.sh /tmp/wp_script.sh 
RUN chmod +x /tmp/wp_script.sh
EXPOSE 9000

ENTRYPOINT [ "/tmp/wp_script.sh" ] 
CMD [ "php-fpm8.2", "-F"]