# Installation des paquets
apt-get update && apt-get upgrade -y
apt-get install -y apt-utils
apt-get install -y openssl
apt-get install -y nginx
apt-get install -y mariadb-server
apt-get install -y php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cli php-fpm php-cgi
apt-get install -y php-mysql
apt-get install -y libnss3-tools
apt-get install -y wget

# Configuration de mariadb-server
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'ebenyoub' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

# Configuration Certificat OpenSSL

mkdir -p /etc/nginx/ssl
chmod 700 /etc/nginx/ssl
chown -R www-data /var/www/*
chmod -R 755 /var/www/*
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/localhost.key -out /etc/nginx/ssl/localhost.csr -subj "/C=FR/ST=France/L=Lyon/O=ebenyoub/OU=42/CN=localhost"

# Configuration de Nginx
mkdir -p /var/www/ebenyoub
mv /ft_server/index.html /var/www/ebenyoub
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
mv /ft_server/localhost.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost.conf /etc/nginx/sites-enabled/

# Installation de Wordpress
wget https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp -rf wordpress /var/www/ebenyoub
cp /ft_server/wp-config.php /var/www/ebenyoub/wordpress/
rm -rf /var/www/ebenyoub/wordpress/wp-config-sample.php

# Installation de Phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages /var/www/ebenyoub/phpmyadmin
ln -s /usr/share/phpmyadmin /usr/share/nginx/html

# Acceder à la configuration
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*
chmod 744 /ft_server/index.sh

# Redémarrer les services
service mysql restart
/etc/init.d/php*-fpm start
service nginx restart
