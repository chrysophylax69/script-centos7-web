#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################


# Mise à jour du system

clear
echo ""
echo "Updating system and installing required packages."
echo ""
echo ""
read -e -p "Installation avec PHP 7 ? [y/N] : " PHP7
read -e -p "Installation avec Apache (nginx par defaut) ? [y/N] : " WEBSERV
sleep 3
	
sudo yum -y install epel-release
sudo yum -y install wget
sudo yum -y update

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
sudo wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo rpm -Uvh remi-release-7.rpm
sudo yum-config-manager --enable remi-php70
fi

sudo yum -y update
sudo yum -y upgrade
sudo yum -y groupinstall "Development Tools" 
sudo yum -y install gmp-devel mariadb-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git net-tools bind-utils gcc make
echo ""
echo "Arret du Firewall :"
echo ""
sudo systemctl stop firewalld
sudo systemctl disabled firewalld
echo ""
sudo systemctl status firewalld
echo ""
echo "Vérifixation de SeLinux :"
echo ""
sudo sed -i 's/enforcing/disabled/' /etc/selinux/config
sudo sed -i 's/permissive/disabled/' /etc/selinux/config
echo ""
sudo sestatus
echo ""
sleep 5
clear


# Installation WEBSERV

if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
	echo ""
	echo "Installation Apache :"
	echo ""
	sleep 3
	sudo yum -y install httpd
	echo ""
	sudo systemctl start httpd
	sudo systemctl enable httpd
	echo ""
	echo "Vérification de Apache :"
	echo ""
	sudo systemctl status httpd
	echo ""
	sleep 5
	clear
else
	echo ""
	echo "Installation NGINX :"
	echo ""
	sleep 3
	sudo yum -y install nginx
	echo ""
	sudo systemctl start nginx
	sudo systemctl enable nginx
	echo ""
	echo "Vérification de NGINX :"
	echo ""
	sudo systemctl status nginx
	echo ""
	sleep 5
	clear
fi


# Installation DB (MariaDB)

echo ""
echo "Installation MariaDB :"
echo ""
sleep 3
sudo yum -y install mariadb-server mariadb
sudo systemctl start mariadb 
sudo systemctl enable mariadb
echo ""
echo "Vérification de DB :"
echo ""
sudo systemctl status mariadb
echo ""
echo "Mise en route DB :"
sudo mysql_secure_installation
echo ""
sleep 5
clear


# Installation PHP
echo ""
echo "Installation PHP :"
echo ""
sleep 3

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
	sudo yum -y install php70 php70-php-devel php70-php-mysqlnd php70-php-common php70-php-gd php70-php-ldap php70-php-odbc php70-php-pear php70-php-xml php70-php-xmlrpc php70-php-mbstring php70-php-snmp php70-php-soap php70-php-mcrypt php70-php-pecl-memcache php70-php-opcache php70-php-imap php7.0-cli ImageMagick ruby-libs php70-php-intl php70-php-pspell php70-php-recode php70-php-tidy php70-php-pecl-imagick php70-php-pecl-zip
	sudo systemctl start memcached
	sudo systemctl enable memcached
	else
	sudo yum -y install php70 php70-php-devel php70-php-mysqlnd php70-php-common php70-php-fpm php70-php-gd php70-php-ldap php70-php-odbc php70-php-pear php70-php-xml php70-php-xmlrpc php70-php-mbstring php70-php-snmp php70-php-soap php70-php-mcrypt php70-php-pecl-memcache php70-php-opcache php70-php-imap php7.0-cli ImageMagick ruby-libs php70-php-intl php70-php-pspell php70-php-recode php70-php-tidy php70-php-pecl-imagick php70-php-pecl-zip
	sudo systemctl start memcached
	sudo systemctl enable memcached
	sudo systemctl start php70-php-fpm
	sudo systemctl enable php70-php-fpm
	fi
else		
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		sudo yum -y install php php-devel php-mysql php-common php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-pecl-memcache php-imap php-cli ImageMagick ruby-libs php-intl php-pspell php-recode php-tidy php-pecl-imagick
		sudo systemctl start memcached
		sudo systemctl enable memcached	
	else
		sudo yum -y install php php-devel php-mysql php-common php-fpm php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-pecl-memcache php-imap php-cli ImageMagick ruby-libs php-intl php-pspell php-recode php-tidy php-pecl-imagick
		sudo systemctl start memcached
		sudo systemctl enable memcached
		sudo systemctl start php-fpm
		sudo systemctl enable php-fpm
	fi
fi

echo ""
echo "Vérification de Memcache :"
echo ""
sudo systemctl status memcached
echo ""
echo ""

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl status php70-php-fpm
	fi
else
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl status php-fpm
	fi
fi
echo ""
sleep 5
clear


# Installation APC
#echo ""
#echo "Installation APC :"
#echo ""
#sleep 3

#if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
#sudo yum -y install php70-php-devel pcre-devel
#else
#sudo yum -y install php-devel pcre-devel
#fi
#sudo pecl install apc
#echo "extension=apc.so" >> /etc/php.d/apc.ini
#echo ""
#sleep 5
#clear


# Installation phpMyAdmin
echo ""
echo "Installation phpMyAdmin :"
echo ""
sleep 3

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
sudo mkdir /var/www/
sudo mkdir /var/www/html
sudo wget https://files.phpmyadmin.net/phpMyAdmin/4.7.7/phpMyAdmin-4.7.7-all-languages.tar.gz
sudo tar xvfz phpMyAdmin-4.7.7-all-languages.tar.gz
sudo mv phpMyAdmin-4.7.7-all-languages phpmyadmin
sudo mv phpmyadmin/ /var/www/html/
chown -R nobody.nobody /var/www/html/phpmyadmin
sudo cp /var/www/html/phpmyadmin/config.sample.inc.php /var/www/html/phpmyadmin/config.inc.php
else
sudo yum -y install phpMyAdmin
fi
sudo touch /var/www/html/info.php
sudo echo "<?php phpinfo(); ?>" |sudo tee  /var/www/html/info.php
sudo touch /var/www/html/index.html
sudo echo "TEST OK" |sudo tee  /var/www/html/index.html
echo ""
sleep 5
clear

# Verif config

if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
	echo ""
	echo "Relance Apache :"
	echo ""
	sleep 3
	sudo systemctl restart httpd
	echo ""
	echo ""
else
	echo ""
	echo "Relance Nginx + PHP-FPM :"
	echo ""
	sleep 3
	sudo systemctl restart nginx
	echo ""
	echo ""
fi

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl restart php70-php-fpm
	fi
else
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl restart php-fpm
	fi
fi
	
echo ""
echo ""

if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
	sudo systemctl status httpd
else
	sudo systemctl status nginx
fi
echo ""
echo ""

if [[ ("$PHP7" == "y" || "$PHP7" == "Y") ]]; then
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl status php70-php-fpm
	fi
else
	if [[ ("$WEBSERV" == "y" || "$WEBSERV" == "Y") ]]; then
		echo ""
	else
		sudo systemctl status php-fpm
	fi
fi
echo ""
echo ""
sudo systemctl status memcached
echo ""
echo ""
echo "Installation Finish. Voir le readme pour la conf."
