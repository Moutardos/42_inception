echo "Installing WP"
mkdir -p /run/php ${WWW_DIR}

if [ ! -f ${WWW_DIR}/.done ]; then
	mkdir -p ${WWW_DIR}/${SERVER_NAME}
	cd ${WWW_DIR}/${SERVER_NAME}
    echo "Current directory: $(pwd)"
	curl -O https://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz 
	echo "moving files..."
	mv wordpress/* .
	echo "done!"
	rm -rf wordpress latest.tar.gz
	chown -R www-data:www-data ${WWW_DIR}/${SERVER_NAME}
	touch ${WWW_DIR}/.done
	echo "finished"
else
	echo "WP is already installed"
fi

echo "executing php"
exec php-fpm8.2 -F -R