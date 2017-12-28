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
	sleep 3
	
	sudo yum -y epel-release
	sudo yum -y update
	sudo yum -y upgrade
	sudo yum install wget
	sudo wget -q http://rpms.remirepo.net/enterprise/remi-release-7.rpm
	sudo wget -q https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
	rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm
	sudo yum -y groupinstall "Development Tools" 
	sudo yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git net-tools bind-utils
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
	
	
	# Installation NGINX
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
	sudo yum -y install php70 php70-php-mysqlnd php70-php-common php70-php-fpm php70-php-gd php70-php-ldap php70-php-odbc php70-php-pear php70-php-xml php70-php-xmlrpc php70-php-mbstring php70-php-snmp php70-php-soap php70-php-mcrypt php70-php-pecl-memcache php70-php-opcache php70-php-imap php7.0-cli ImageMagick ruby-libsphp70-php-intl php70-php-pspell php70-php-recode php70-php-tidy memcached php70-php-pecl-imagick php70-php-pecl-zip
	#sudo systemctl start memcached
	#sudo systemctl enable memcached
	sudo systemctl start php70-php-fpm
	sudo systemctl enable php70-php-fpm
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	sudo systemctl status php70-php-fpm
	echo ""
	sleep 5
	clear
	
	
	# Installation APC
	echo ""
    echo "Installation APC :"
    echo ""
	sleep 3
	sudo yum -y install php70-php-devel pcre-devel gcc make
	cd
	sudo pecl install apc
	echo "extension=apc.so" >> /etc/php.d/apc.ini
	echo ""
	sleep 5
	clear
	
	
	# Installation phpMyAdmin
	echo ""
    echo "Installation phpMyAdmin :"
    echo ""
	sleep 3
	sudo yum -y install phpMyAdmin
	echo ""
	echo ""
    echo "Relance Apache + PHP-FPM :"
	echo ""
	sudo systemctl restart nginx
	sudo systemctl restart php70-php-fpm 
	echo ""
	echo ""
	sudo systemctl status nginx
	echo ""
	sudo systemctl status php70-php-fpm
	echo ""
	echo ""
	echo "Installation Finish. Voir le readme pour la conf."