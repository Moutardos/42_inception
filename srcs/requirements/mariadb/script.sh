echo "Starting mariadb service"

if [ ! -f /var/lib/mysql/.done ]; then
	mariadb-install-db --user mysql
	mariadbd --bootstrap --user mysql << STOP &
	FLUSH PRIVILEGES;
	CREATE DATABASE $MARIA_DB_NAME;
	CREATE USER "$MARIA_DB_USERNAME"@'%' IDENTIFIED BY "$MARIA_DB_PASSWORD";
	GRANT ALL PRIVILEGES ON *.* TO "$MARIA_DB_USERNAME"@'%' IDENTIFIED BY "$MARIA_DB_PASSWORD";
	FLUSH PRIVILEGES;
	exit
STOP
	wait
	touch /var/lib/mysql/.done
else
	echo "mariadb is already installed"
fi

echo "starting mariadbd"
exec mariadbd --user mysql