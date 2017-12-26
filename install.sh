#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################

	# Mise à jour du system

    echo ""
    echo "Updating system and installing required packages."
    echo ""
	
	yum -y update
	yum -y upgrade
	yum -y groupinstall "Development Tools" 
	yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget git
	echo ""
    echo "Arret du Firewall :"
	echo ""
	systemctl stop firewalld
	echo ""
	systemctl status firewalld
	echo ""
	echo "Vérifixation de SeLinux :"
	echo ""
	sestatus
	echo ""
	sleep 3
	
	
	# Installation NGINX
	clear
	sleep 1
	echo ""
    echo "Installation NGINX :"
    echo ""
	yum -y install NGINX
	echo ""
	systemctl start NGINX.service
	systemctl enable NGINX.service
	echo ""
    echo "Vérification de NGINX :"
	echo ""
	systemctl status NGINX.service
	echo ""
	sleep 3
	
		
	# Installation DB (MariaDB)
	clear
	echo ""
    echo "Installation MariaDB :"
    echo ""
	yum -y install mariadb-server mariadb
	systemctl start mariadb 
	systemctl enable mariadb
	echo ""
    echo "Vérification de DB :"
	echo ""
	systemctl status mariadb.service
	echo "Mise en route DB :"
	mysql_secure_installation
	echo ""
	sleep 3
	
	
	# Installation PHP
	clear
	echo ""
    echo "Installation PHP :"
    echo ""
	yum -y install php php-mysql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-memcache
	systemctl start memcached
	systemctl enable memcached
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	systemctl status memcached
	echo ""
	sleep 3
	
	
	# Installation APC
	clear
	echo ""
    echo "Installation APC :"
    echo ""
	yum -y install php-pear php-devel httpd-devel pcre-devel gcc make
	cd
	pecl install apc
	echo "extension=apc.so" > /etc/php.d/apc.ini
	echo ""
	sleep 3
	
	
	# Installation phpMyAdmin
	clear
	echo ""
    echo "Installation phpMyAdmin :"
    echo ""
	yum -y install phpMyAdmin
	echo ""
    echo "Relance Apache :"
	echo ""
	systemctl restart NGINX.service
	echo ""
	echo ""
	systemctl status NGINX.service
	echo ""