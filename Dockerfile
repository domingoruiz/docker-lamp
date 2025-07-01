FROM php:8.4-apache

# Autor
LABEL maintainer="Domingo Ruiz Arroyo <ordenadordomi@gmail.com>"

# Instalación básica
RUN apt-get update && apt-get install -y \
    openssh-server \
    unzip \
    git \
    curl \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libssl-dev \
    && docker-php-ext-install pdo pdo_mysql mysqli zip gd xml mbstring

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# SSH root user
RUN echo 'root:root' | chpasswd && mkdir /var/run/sshd

# SSL Apache
RUN a2enmod ssl rewrite
RUN a2ensite default-ssl

# HTTPS y SSH expuestos
EXPOSE 80 443 22

# Permitimos SSH de root
RUN sed -i 's/^#\?PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

# Iniciamos los servicios
CMD service ssh start && apache2-foreground