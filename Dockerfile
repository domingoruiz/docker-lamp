FROM ubuntu:20.04
MAINTAINER Domingo Ruiz Arroyo <ordenadordomi@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y
RUN apt install -y apache2
RUN apt install -y mysql-server
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-common php7.0-mbstring php7.0-gd php7.0-intl php7.0-xml php7.0-mysql php7.0-mcrypt php7.0-zip

RUN apt-get install -y wget unzip
RUN cd /var/www/html/
RUN chmod -R 7777 /var/www/html/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.zip
RUN unzip phpMyAdmin-4.9.7-all-languages.zip
RUN rm phpMyAdmin-4.9.7-all-languages.zip
RUN mv phpMyAdmin-4.9.7-all-languages/ /var/www/html/phpmyadmin/
RUN echo "#!/bin/sh" > startserver
RUN echo "service mysql start && service apache2 start" >> startserver
RUN chmod +x startserver
RUN mv startserver /usr/bin/

EXPOSE 80
CMD startserver; sleep infinity;