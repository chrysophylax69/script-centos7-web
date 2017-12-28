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
	sudo yum -y install php php-mysql php-common php-fpm php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-pecl-memcache
	sudo systemctl start memcached
	sudo systemctl enable memcached
	sudo systemctl start php-fpm
	sudo systemctl enable php-fpm
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	sudo systemctl status memcached
	echo ""
	sudo systemctl status php-fpm
	echo ""
	sleep 5
	clear
	
	
	# Installation APC
	echo ""
    echo "Installation APC :"
    echo ""
	sleep 3
	sudo yum -y install php-pear php-devel pcre-devel gcc make
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
	sudo systemctl restart php-fpm 
	echo ""
	echo ""
	sudo systemctl status nginx
	echo ""
	sudo systemctl status php-fpm
	echo ""
	sudo systemctl status memcached
	echo ""
	echo ""
	echo "Installation Finish. Voir le readme pour la conf."