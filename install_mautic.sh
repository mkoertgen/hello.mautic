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
sudo apt install -y php libapache2-mod-php libapache2-mod-php php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl php-tidy php-mysql php-cli php-mcrypt php-ldap php-zip php-curl php-sqlite3 php-imap
sudo nano sudo nano /etc/php/7.0/apache2/php.ini
# -file_uploads = On
# -allow_url_fopen = On
# +memory_limit = 256M
# +upload_max_filesize = 64M
# +max_execution_time = 360
# +date.timezone = America/Chicago

# 4. Create Mautic database
sudo mysql -u root -p 'your password' -t<<EOF
CREATE DATABASE mauticdb;
CREATE USER 'mauticuser'@'localhost' IDENTIFIED BY 'mautic_password';
GRANT ALL ON mauticdb.* TO 'mauticuser'@'localhost' IDENTIFIED BY 'mautic_password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT;
EOF

# 5. Mautic
cd /tmp && wget https://www.mautic.org/download/latest
sudo mkdir /var/www/html/mautic
sudo apt-get install unzip -y
sudo unzip latest -d /var/www/html/mautic
sudo chown -R www-data:www-data /var/www/html/mautic/
sudo chmod -R 755 /var/www/html/mautic/

# 6. Configure Apache2
sudo nano /etc/apache2/sites-available/mautic.conf
# paste/copy file

# 7. Enable the Mautic and Rewrite Module 
sudo a2ensite mautic.conf
sudo a2enmod rewrite

# 8. Restart Apache2
sudo systemctl restart apache2.service

# Now goto http://your-domain.com/mautic
