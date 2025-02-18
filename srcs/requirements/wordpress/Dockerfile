FROM debian:bookworm

ARG SSL_DIR
ARG WWW_DIR
ARG SERVER_NAME

RUN apt-get update && \
	apt-get install -y \
		php-fpm \
		php-mysql \
		curl \
		tar


COPY wp_script.sh /tmp/wp_script.sh 
RUN chmod +x /tmp/wp_script.sh
EXPOSE 9000

CMD /tmp/wp_script.sh && php-fpm
