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
	yum -y install gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget
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
	
	
	# Installation Nginx
	echo ""
    echo "Installation Nginx :"
    echo ""
	yum -y install nginx
	echo ""
	systemctl start nginx.service
	systemctl enable nginx.service
	echo ""
    echo "Vérification de Nginx :"
	echo ""
	systemctl status nginx.service
	echo ""
	
		
	# Installation DB (MariaDB)
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
	
	
	# Installation PHP
	echo ""
	yum -y install php php-mysql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-memcache
	systemctl start memcached
	systemctl enable memcached
	echo ""
    echo "Vérification de Memcache :"
	echo ""
	systemctl status memcached
	echo ""
	
	
	# Installation APC
	echo ""
	yum -y install php-pear php-devel pcre-devel gcc make
	cd
	pecl install apc
	echo "extension=apc.so" > /etc/php.d/apc.ini
	echo ""
	
	
	# Installation APC
	echo ""
	yum -y install phpMyAdmin
	echo ""
    echo "Relance Apache :"
	echo ""
	systemctl restart nginx.service
	echo ""
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	