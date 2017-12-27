# script-centos-web
Script auto CentOS 7 => 
Installation automatique : Nginx - MariaDB - PHP - PhpMyAdmin - APC

sudo ./install.sh

Conf =>
modif /etc/php-fpm.d/www.conf => pour exemple 

modif /etc/nginx/conf.d/default.conf => pour exemple (fichier non complet)

modif /etc/php.ini => cgi.fix_pathinfo=0

IMPORTANT =>
* Bien activer "listen = /var/run/php-fpm/php-fpm.sock" dans /etc/php-fpm.d/www.conf
* Bien mettre "server_name  ADRESSE_IP_DU_SERVEUR;" dans /etc/nginx/conf.d/default.conf
