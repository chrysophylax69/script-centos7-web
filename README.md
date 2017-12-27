# script-centos-web
Script auto CentOS 7 => 
Installation automatique : Nginx - MariaDB - PHP - PhpMyAdmin - APC

sudo ./install.sh

Conf =>
modif /etc/php-fpm.d/www.conf => a adapter
modif /etc/nginx/conf.d/default.conf => pour exemple (fichier non complet)
modif /etc/php.ini => cgi.fix_pathinfo=0
