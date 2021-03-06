FROM		    ubuntu:vivid
MAINTAINER	Victor Argote "contacto@victorargote.com"

ADD         owncloud-7.0.4.tar.bz2 /var/www/
ADD         bootstrap.sh /usr/bin/
ADD         nginx_ssl.conf /root/
ADD         nginx.conf /root/
ADD         config.php /var/www/owncloud/config/

RUN         apt-get update && \
            apt-get install -y ssh nano php5-cli php5-gd php5-pgsql php5-sqlite php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu php5-imagick php5-fpm smbclient nginx && \
            mkdir /var/www/owncloud/data && \
            chown -R www-data:www-data /var/www/owncloud
            chmod +x /usr/bin/bootstrap.sh

ADD         php.ini /etc/php5/fpm/

# SSH Support
# allow login with password
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo 'root:toor' | chpasswd

EXPOSE      22
EXPOSE      80
EXPOSE      443

ENTRYPOINT  ["bootstrap.sh"]
