FROM debian:bookworm

ARG SSL_DIR
ARG WWW_DIR

RUN apt-get update && \
	apt-get install -y \
		mariadb-server \
		mariadb-client



COPY script.sh /tmp/script.sh

RUN	chmod +x /tmp/script.sh

COPY my.cnf /root/.my.cnf

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql

CMD chmod +g /tmp/script.sh && /tmp/script.sh 
