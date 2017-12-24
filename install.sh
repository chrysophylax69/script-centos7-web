#!/bin/bash
################################################################################
#
#	Xavatar / Tatar
#
################################################################################

	# Mise à jour du system

    output ""
    output "Updating system and installing required packages."
    output ""
	
	yum -y update
	yum -y upgrade
	yum -y groupinstall "Development Tools" gmp-devel mysql-devel curl-devel libidn-devel libssh2-devel python-devel openldap-devel vim memcached wget
	output ""
    output "Arret du Firewall :"
	output ""
	systemctl stop firewalld
	output ""
	systemctl status firewalld
	output ""
    output "Vérifixation de SeLinux :"
	output ""
	sestatus
	output ""
	
	
	# Installation Apache
	output ""
    output "Installation Apache :"
    output ""
	yum -y install httpd
	output ""
	systemctl start httpd.service
	systemctl enable httpd.service
	output ""
    output "Vérification de Apache :"
	output ""
	systemctl status httpd.service
	output ""
	
		
	# Installation DB (MariaDB)
	output ""
	yum -y install mariadb-server mariadb
	systemctl start mariadb 
	systemctl enable mariadb
	output ""
    output "Vérification de DB :"
	output ""
	systemctl status mariadb.service
	output "Mise en route DB :"
	mysql_secure_installation
	output ""
	
	
	# Installation PHP
	output ""
	yum -y install php php-mysql php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap php-mcrypt curl curl-devel php-memcache
	systemctl start memcached
	systemctl enable memcached
	output ""
    output "Vérification de Memcache :"
	output ""
	systemctl status memcached
	output ""
	
	
	# Installation APC
	output ""
	yum -y install php-pear php-devel httpd-devel pcre-devel gcc make
	cd
	pecl install apc
	echo "extension=apc.so" > /etc/php.d/apc.ini
	output ""
	
	
	# Installation APC
	output ""
	yum -y install phpMyAdmin
	output ""
    output "Relance Apache :"
	output ""
	systemctl restart httpd.service
	output ""
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	