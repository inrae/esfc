#!/bin/bash
# install a new instance into a server
# must be executed with login root
# creation : Eric Quinton - 2017-05-04

echo "this script will install apache server and php, postgresql and deploy the current version of esfc."
read -p "Do you want to continue [y/n]?" response
if [ "$response" = "y" ] 
then
# installing packages
apt-get install unzip apache2 libapache2-mod-php7.0 php7.0 php7.0-ldap php7.0-pgsql php7.0-mbstring php7.0-xml php7.0-zip php7.0-imagick php7.0-gd fop postgresql postgresql-client
a2enmod ssl
a2enmod headers
a2enmod rewrite
# chmod -R g+r /etc/ssl/private
# usermod www-data -a -G ssl-cert
a2ensite default-ssl
a2ensite 000-default

# creation of directory
cd /var/www/html
mkdir esfc
cd esfc

# download software
echo "download software"
wget https://github.com/Irstea/esfc/archive/master.zip
unzip esfc.zip
mv esfc-master esfc-1.8
ln -s esfc-1.8 esfc

# update rights on files
chmod -R 755 .

# create param.inc.php file
mv esfc/param/param.inc.php.dist esfc/param/param.inc.php
# creation of database
echo "creation of the database"
cd esfc/install
su postgres -c "psql -f init_by_psql.sql"
cd ../..
echo "you may verify the configuration of access to postgresql"
echo "look at /etc/postgresql/9.6/main/pg_hba.conf (verify your version). Only theses lines must be activate:"
echo '# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5'

read -p "Enter to continue" answer

# install backup program
echo "backup configuration - dump at 20:00 into /var/lib/postgresql/backup"
echo "please, set up a data transfert mechanism to deport them to another medium"
cp esfc/install/pgsql/backup.sh /var/lib/postgresql/
chown postgres /var/lib/postgresql/backup.sh
line="0 20 * * * /var/lib/postgresql/backup.sh"
#(crontab -u postgres -l; echo "$line" ) | crontab -u postgres -
echo "$line" | crontab -u postgres -

# update rights to specific software folders
chmod -R 750 .
mkdir esfc/display/templates_c
chgrp -R www-data .
chmod -R 770 esfc/display/templates_c
chmod -R 770 esfc/tmp

# generate rsa key for encrypted tokens
echo "generate encryption keys for identification tokens"
openssl genpkey -algorithm rsa -out esfc/param/id_esfc -pkeyopt rsa_keygen_bits:2048
openssl rsa -in esfc/param/id_esfc -pubout -out esfc/param/id_esfc.pub
chown www-data esfc/param/id_esfc

# creation of virtual host
echo "creation of virtual site"
cp esfc/install/apache2/esfc.conf /etc/apache2/sites-available/
a2ensite esfc
echo "you must modify the file /etc/apache2/sites-available/esfc.conf"
echo "address of your instance, ssl parameters),"
echo "then run this command:"
echo "service apache2 reload"
read -p "Enter to terminate" answer

fi
# end of script
