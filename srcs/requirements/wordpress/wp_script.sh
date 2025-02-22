#!/bin/bash

echo "Installing WP"
mkdir -p /run/php ${WWW_DIR}

if [ ! -f ${WWW_DIR}/.done ]; then
	mkdir -p ${WWW_DIR}
	cd ${WWW_DIR}
    echo "Current directory: $(pwd)"
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	./wp-cli.phar --info
	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create --dbname=${MARIA_DB_NAME} --dbuser=${MARIA_DB_USERNAME} --dbpass=${MARIA_DB_PASSWORD} --dbhost=mariadb:3306 --allow-root
	./wp-cli.phar core install --url=https://${SERVER_NAME} --title="Inception" --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_MAIL} --allow-root
	./wp-cli.phar user create ${WP_USER_NAME} ${WP_USER_MAIL} --user_pass=${WP_USER_PASSWORD} --allow-root
	./wp-cli.phar rewrite structure '/%year%/%monthnum%/%postname%/' --allow-root
	./wp-cli.phar user list --fields=ID,user_login,roles --allow-root
	chown -R www-data:www-data ${WWW_DIR}
	chmod -R g+w ${WWW_DIR}

	# chmod -R 664 ${WWW_DIR}
	touch ${WWW_DIR}/.done $
	echo "finished"
else
	echo "WP is already installed"
fi

echo "executing php"
exec "$@"


