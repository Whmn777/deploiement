#!/bin/bash

#ceci est un commentaire
echo "Installation paquet APT"
apt update
apt install -y mariadb-server mariadb-client
apt install -y php apache2 libapache2-mod-php
apt install -y  composer
apt install vim git vim git snapd

echo "Config snapd + certbot"

snap install core
snap refresh core
snap install --classic certbot

CERTBOT=$(ls /usr/bin | grep certbot)
if [ -z "$CERTBOT"]
then
	echo"On crée le lien"
	ln -s /snap/bin/certbot /usr/bin/certbot
	fi

MD5_DEST=$(md5sum /etc/apache2/sites-available/000-default.conf | awk '{print$1}')
MD5_SRC=$(md5sum 000-default.conf | awk '{print$1}')

if [ "$MD5_DEST" != "$MD_5SRC" ]
then
        echo "On écrase la conf apache"
        cp 000-default.conf /etc/apache2/sites-available/000-default.conf
        service apache2 restart
        fi

echo "pull sources git"
cd /var/www/html
git pull origin master
composer install
chown -R www-data:www-data /var/www/html/
source .env.dev

echo "Penser à taper la commande certbot --apache"
