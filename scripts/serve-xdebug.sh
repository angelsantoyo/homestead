#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.
if [ ! -f /etc/php/mods-available/xdebug.ini ]; then
cd /tmp
wget http://xdebug.org/files/xdebug-2.4.0rc3.tgz
tar xvzf xdebug-2.4.0rc3.tgz
cd xdebug-2.4.0RC3/
phpize
./configure
make
sudo cp modules/xdebug.so /usr/lib/php/20151012/

sudo rm /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo mkdir /etc/php/mods-available
sudo touch /etc/php/mods-available/xdebug.ini

block="; configuration for php xdebug module
; priority=20
zend_extension=/usr/lib/php/20151012/xdebug.so
xdebug.idekey="phpstorm"
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.max_nesting_level=300
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1"
echo "$block" > "/etc/php/mods-available/xdebug.ini"

sudo ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini
sudo ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini

sudo service php7.0-fpm restart
fi