#!/bin/bash

LOG_FILE="/var/log/install_$(date +'%Y-%m-%d').log"

exec &>> "$LOG_FILE"

git clone https://github.com/mkassaf/SimpleApacheApp

if ! command -v apache2 &> /dev/null; then
    echo "Apache2 is not installed"
    sudo apt-get update
    sudo apt-get install apache2
else
    apache_version=$(apache2 -v | grep -oP 'Apache/(\d+\.\d+\.\d+)')
    if [[ "$apache_version" < "Apache/2.0.0" ]]; then
        sudo apt-get remove apache2
        sudo apt-get install apache2
    else
        echo "Apache2 version is already up to date"
    fi
fi

sudo mkdir -p /var/www/SimpleApp

sudo cp -r SimpleApacheApp/App/* /var/www/SimpleApp/

sudo cp SimpleApacheApp/simpleApp.conf /etc/apache2/sites-available/

sudo a2dissite 000-default.conf

sudo a2ensite simpleApp.conf

sudo systemctl reload apache2

sudo service apache2 restart

sudo chown -R www-data:www-data /var/www/SimpleApp
sudo chmod -R 755 /var/www/SimpleApp

if curl -Is http://localhost | head -1 | grep "200 OK"; then
    echo "Working"
else
    echo "Not working as expected."
fi
