FROM php:8.2-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Instalar extensões do PHP necessárias para o Laravel
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar o projeto para o container
COPY . /var/www

# Ajustar permissões
RUN chown -R www-data:www-data /var/www
RUN chmod 755 /var/www

# Expor a porta 9000 (usada pelo PHP-FPM)
EXPOSE 9000

CMD ["php-fpm"]
