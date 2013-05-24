#!/bin/bash

mkdir ~/neon-install/
cd ~/neon-install/
touch ~/neon-install/install.log
exec 3>&1 > ~/neon-install/install.log 2>&1

############################################################
# Functions
############################################################

function install {
	DEBIAN_FRONTEND=noninteractive apt-get -q -y install "$1"
	apt-get clean
}

function remove {
	/etc/init.d/"$1" stop
	service "$1" stop
	export DEBIAN_PRIORITY=critical
	export DEBIAN_FRONTEND=noninteractive
	apt-get -q -y remove "$1"
	apt-get clean
}

function check_sanity {
	# Do some sanity checking.
	if [ $(/usr/bin/id -u) != "0" ]
	then
		die 'Neon must be installed as root. Please log in as root and try again.'
	fi

	if [ ! -f /etc/debian_version ]
	then
		die "Neon must be installed on Debian 6.0."
	fi
	
	if [[ $HOSTNAME != *.* ]]
	then
        die "You must set a valid hostname (server.example.com) before installing Neon. You can do this with the command: hostname server.example.com"
	fi

}

function die {
	echo "ERROR: $1" > /dev/null 1>&2
	exit 1
}

function status {
	echo $1;
	echo $1 >&3
}

check_sanity

status "====================================="
status "     Welcome to Neon Installation"
status "====================================="
status "Neon will remove any existing apache,"
status "nginx, mysql or php services you have"
status "installed upon this server. It will"
status "also delete all custom config files"
status "that you may have."
status " "
status "It is reccomended that you run this"
status "installer in a screen."
status " "
status "This script will begin installing"
status "Neon in 10 seconds. If you wish to"
status "cancel the install press CTRL + C"
sleep 10
status " "
status "Neon is now being installed."
status "Begining cleanup..."

remove="apache2 apache* apache2* apache2-utils mysql* php* nginx lighttpd httpd* php5-fpm vsftpd proftpd exim qmail postfix sendmail"

pkill apache
pkill apache2
aptitude -y purge ~i~napache
apt-get --purge -y autoremove apache*
apt-get remove apache2-utils
for program in $remove
do
	remove $program
	x=$(($x + 1));
	status "Clean Up: $x / 23"
done
apt-get autoremove

kill -9 $( lsof -i:80 -t )
x=$(($x + 1));
status "Clean Up: $x / 21"

kill -9 $( lsof -i:3306 -t )
x=$(($x + 1));
status "Clean Up: $x / 23"

update-rc.d -f apache2 remove
x=$(($x + 1));
status "Clean Up: $x / 23"

update-rc.d -f apache remove
x=$(($x + 1));
status "Clean Up: $x / 23"

update-rc.d -f nginx remove
x=$(($x + 1));
status "Clean Up: $x / 23"

update-rc.d -f lighttpd remove
x=$(($x + 1));
status "Clean Up: $x / 23"

update-rc.d -f httpd remove
x=$(($x + 1));
status "Clean Up: $x / 23"

status "Clean Up Completed."
status "Starting installation please wait..."

echo "deb http://repo.neoncp.com/dotdeb stable all" >> /etc/apt/sources.list
wget http://repo.neoncp.com/dotdeb/dotdeb.gpg
cat dotdeb.gpg | apt-key add -
rm -rf dotdeb.gpg
apt-get update
y=$(($y + 1));
status "Install: $y / 31"

install="nginx php5 vim openssl php5-mysql zip unzip sqlite3 php5-sqlite php5-curl php-pear php5-dev acl libcurl4-openssl-dev php5-gd php5-imagick php5-imap php5-mcrypt php5-xmlrpc php5-xsl php5-fpm libpcre3-dev build-essential php-apc git-core pdns-server pdns-backend-mysql host mysql-server phpmyadmin"

for program in $install
do
	install $program
	y=$(($y + 1));
	status "Install: $y / 31"
done

if ! type -p nginx > /dev/null; then
    status "Unfortunatly nginx failed to install. Neon install aborting."
	exit 1
fi

if ! type -p php > /dev/null; then
    status "Unfortunatly php5 failed to install. Neon installation aborting."
	exit 1
fi

if ! type -p git > /dev/null; then
    status "Unfortunatly git-core failed to install. Neon installation aborting."
	exit 1
fi

if ! type -p mysql > /dev/null; then
    status "Unfortunatly mysql failed to install. Neon installation aborting. (Error: #1)"
	exit 1
fi

/etc/init.d/mysql stop
invoke-rc.d mysql stop
/etc/init.d/nginx stop
/etc/init.d/php5-fpm stop
status "Config: 1 / 13"

wget https://raw.github.com/BlueVM/Neon/develop/neonpanel/includes/configs/my.cnf
mv /etc/my.cnf /etc/my.cnf.backup
mv my.cnf /etc/my.cnf
status "Config: 2 / 13"

/etc/init.d/mysql start
mysqlpassword=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};`
salt=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};`
mysqladmin -u root password $mysqlpassword

while ! mysql -u root -p$mysqlpassword  -e ";" ; do
       status "Unfortunatly mysql failed to install correctly. Neon installation aborting (Error #2)".
done
status "Config: 3 / 13"

wget https://raw.github.com/BlueVM/Neon/develop/neonpanel/includes/configs/php.conf
mv php.conf /etc/php5/fpm/pool.d/www.conf
mv /etc/php5/conf.d/apc.ini /etc/php5/apc.old
status "Config: 4 / 13"

mkdir /usr/ssl
cd /usr/ssl
openssl genrsa -out neon.key 1024
openssl rsa -in neon.key -out neon.pem
openssl req -new -key neon.pem -subj "/C=US/ST=Oregon/L=Portland/O=IT/CN=www.neonpanel.com" -out neon.csr
openssl x509 -req -days 365 -in neon.csr -signkey neon.pem -out neon.crt
status "Config: 5 / 13"

cd ~/neon-install/
wget https://raw.github.com/BlueVM/Neon/develop/neonpanel/includes/configs/nginx.neon.conf
rm -rf /etc/nginx/sites-enabled/* 
mv nginx.neon.conf /etc/nginx/sites-enabled/nginx.neon.conf 
status "Config: 6 / 13"

mkdir /var/neon/
git clone -b develop https://github.com/BlueVM/Neon.git /var/neon/
status "Config: 7 / 13"

rm -rf /etc/php5/fpm/php.ini
cp /var/neon/neonpanel/includes/configs/php.ini /etc/php5/fpm/php.ini
status "Config: 8 / 13"

cp /var/neon/neonpanel/includes/configs/pma.php /usr/share/phpmyadmin/
cp /etc/phpmyadmin/config.inc.php /etc/phpmyadmin/config.old.inc.php
cp /var/neon/neonpanel/includes/configs/pma.config.inc.php /etc/phpmyadmin/config.inc.php
status "Config: 9 / 13"

touch /var/neon/data/log.txt
mkdir /var/neon/neonpanel/uploads
mkdir /var/neon/neonpanel/downloads
mkdir /home/root/
status "Config: 10 / 13"

/etc/init.d/mysql start
setfacl -Rm user:www-data:rwx /var/neon/*
mysql -u root --password="$mysqlpassword" --execute="CREATE DATABASE IF NOT EXISTS panel;CREATE DATABASE IF NOT EXISTS dns;"
mysql -u root --password="$mysqlpassword" panel < /var/neon/data.sql
status "Config: 11 / 13"

cp /var/neon/data/config.example /var/neon/data/config.json
mv /etc/powerdns/pdns.conf /etc/powerdns/pdns.old
cp /var/neon/neonpanel/includes/configs/pdns.conf /etc/powerdns/pdns.conf
cp /var/neon/data/config.example /var/neon/data/config.json
sed -i 's/databaseusernamehere/root/g' /var/neon/data/config.json
sed -i 's/databaseusernamehere/root/g' /etc/powerdns/pdns.conf
sed -i 's/databasepasswordhere/'${mysqlpassword}'/g' /var/neon/data/config.json
sed -i 's/databasepasswordhere/'${mysqlpassword}'/g' /usr/share/phpmyadmin/pma.php
sed -i 's/databasepasswordhere/'${mysqlpassword}'/g' /etc/powerdns/pdns.conf
sed -i 's/databasenamehere/panel/g' /var/neon/data/config.json
sed -i 's/databasenamehere/dns/g' /etc/powerdns/pdns.conf
sed -i 's/randomlygeneratedsalthere/'${salt}'/g' /var/neon/data/config.json
status "Config: 12 / 13"

ssh-keygen -t rsa -N "" -f ~/neon-install/id_rsa
mkdir ~/.ssh/
cat id_rsa.pub >> ~/.ssh/authorized_keys
mv id_rsa /var/neon/data/
setfacl -Rm user:www-data:rwx /var/neon/*
status "Config: 13 / 13"

aptitude -y purge ~i~napache
status "Finishing and cleaning up..."
/etc/init.d/nginx start
/etc/init.d/pdns start
/etc/init.d/php5-fpm start
cd /var/neon/neonpanel/
php init.php
rm -rf init.php
cd ~/neon-install/
(crontab -l 2>/dev/null; echo "* * * * * sh /var/neon/data/scripts/stats.sh") | crontab -
ipaddress=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | grep -v '127.0.0.2' | cut -d: -f2 | awk '{ print $1}'`;
wget --delete-after http://www.neoncp.com/installer/report.php?ip=$ipaddress

status "=========NEON_INSTALL_COMPLETE========"
status "Mysql Root Password: $mysqlpassword"
status "You can now login at https://$ipaddress:2026"
status "Username: root"
status "Password: your_root_password"
status "====================================="
status "It is reccomended you download the"
status "log ~/neon-install/neon-install.log"
status "and then delete it from your system."