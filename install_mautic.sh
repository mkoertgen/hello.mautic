#! /bin/bash
# See https://websiteforstudents.com/install-and-configure-mautic-on-ubuntu-17-04-17-10-with-mariadb-and-php-support/

# 1. Apache2
sudo apt install -y apache2
sudo sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf
sudo systemctl stop apache2.service
sudo systemctl start apache2.service
sudo systemctl enable apache2.service

# 2. Maria-DB
sudo apt-get install -y mariadb-server mariadb-client
sudo systemctl stop mariadb.service
sudo systemctl start mariadb.service
sudo systemctl enable mariadb.service
sudo mysql_secure_installation
sudo systemctl restart mariadb.service

# 3. PHP
sudo apt install -y php libapache2-mod-php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-tidy php-mysql php-cli php-mcrypt php-ldap php-zip php-curl php-sqlite3

# 4. Create Mautic database

#...
