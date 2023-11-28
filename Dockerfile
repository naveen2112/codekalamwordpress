FROM php:8.1-fpm
COPY ./tcp.conf /etc/php/8.1/fpm/pool.d
RUN apt update -y
RUN apt install git -y && apt-get install -y \
    libpq-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libxml2-dev \
    zlib1g-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libtidy-dev \
    libxslt1-dev \
    libssl-dev \
    default-mysql-client
RUN docker-php-ext-install pdo_mysql mysqli  mbstring xml gd zip bcmath intl curl 
WORKDIR /home/ubuntu
ADD http://wordpress.org/latest.tar.gz /home/ubuntu
RUN tar -zxvf latest.tar.gz
RUN mv /home/ubuntu/wordpress /var/www/html
RUN rm /var/www/html/wordpress/wp-config-sample.php
COPY ./wp-config.php /var/www/html/wordpress
RUN chmod -R 777 /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress
CMD ["php-fpm"]
