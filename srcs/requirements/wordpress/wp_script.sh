#!/bin/bash

echo "Installing WP"
mkdir -p /run/php ${WWW_DIR}

if [ ! -f ${WWW_DIR}/.done ]; then
	mkdir -p ${WWW_DIR}
	cd ${WWW_DIR}
    echo "Current directory: $(pwd)"
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	chown -R www-data:0 ${WWW_DIR}
	mv wp-cli.phar wp
	./wp --info
	./wp core download --allow-root
	./wp config create --dbname=${MARIA_DB_NAME} --dbuser=${MARIA_DB_USERNAME} --dbpass=${MARIA_DB_PASSWORD} --dbhost=mariadb:3306 --allow-root
	./wp core install --url=https://${SERVER_NAME} --title="Inception" --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_MAIL} --allow-root
	./wp user create ${WP_USER_NAME} ${WP_USER_MAIL} --user_pass=${WP_USER_PASSWORD} --allow-root
	./wp user list --fields=ID,user_login,roles --allow-root
	touch ${WWW_DIR}/.done $
	echo "finished"
else
	echo "WP is already installed"
fi

echo "executing php"
exec "$@"


