# Practica-IAW-1.1- Instalación de Apache HTTP Server, PHP y MySQL Server en Ubuntu Server

## Pasos previos a la instalación

**para la instalación vamos a tener que crear la siguiente estructura de directorios y archivos:**

![](imagenes/directorio.png)

**Una vez creados los archivos y directorios, procedemos a la instalación de las herramientas.**

## Instalación de Apache HTTP Server, PHP y MySQL Server en Ubuntu Server

## 1. Creación del archivo `install_lamp.sh` para la automatización del proceso de instalación

### Actualizamos el sistema y mostramos los comandos que se van ejecutando. 

```
sudo apt update
sudo apt upgrade -y
```

```
set -ex
```

## 1.1 Instalación del Servidor web Apache

```
apt install apache2 -y
```

### Paso 1: Habilitamos el módulo rewrite

```
a2enmod rewrite
```

### Paso 2: Copiamos el archivo de configuracion de apache

```
cp ../conf/000-default.conf /etc/apache2/sites-available
```

> [!IMPORTANT]  
> El archivo `000-default.conf` tiene que quedar como en la imagen:
>![](imagenes/000-default.conf.png)


### Paso 3: Instalamos PHP y algunos módulos para Apache y MySQL

```
apt install php libapache2-mod-php php-mysql -y
```

### Paso 4: Reiniciamos el servicio de apache para aplicar los cambios

```
systemctl restart apache2
```

## 1.2 Instalación de MySQL Server

### Paso 1: Instalamos MYSQL server

```
apt install mysql-server -y
```

### Paso 2: Copiamos el archivo de prueba de PHP en /var/www/html

```
cp ../php/index.php /var/www/html
```

> [!NOTE]  
> Para esto, hace falta un archivo `index.php` y que contenga el siguiente contenido:  
> "<?php
>
>phpinfo();
>
>?>"


> [!IMPORTANT]  
> Esto se hace debido a que en el archivo de configuración `000-default.conf` pusimos una línea que hace que priorice los archivos php frente a los html. Esa línea es: **`DirectoryIndex index.php index.html`**

### Paso 3: Modificamos el propietario y el grupo del archivo index.php

```
chown -R www-data:www-data /var/www/html
```
>:warning:Lo modificamos ya que el grupo www-data pertenece al usuario con el que se ejecuta el servicio Apache y necesita permisos para ver, leer y escribir dentro de ese directorio.

---
## 2. Creación del archivo `install_tools.sh` para la automatización del proceso de instalación

### Importamos el archivo de variables

```
source .env
```

> [!NOTE]  
> Este archivo de configuración se hace para que lo que vamos a hacer mas adelante reconozca las variables configuradas en ese archivo. Todas las variables que aparezcan en este documento, están dentro del archivo `.env`

> [!WARNING]  
> Otra cosa a tener en cuenta es que este archivo es publico en el repositorio y pues toda la gente que vea el repositorio puede ver las contraseñas y usuarios que tiene el archivo, asi que para evitar eso, hacemos un archivo `.gitignore` y dentro de él ponemos `.env` para que ignore ese archivo para que a la hora de subirlo esté oculto al público. Lo que podemos hacer para que la gente sepa que variables se configuran podemos hacer un `.env.example` y dentro poner las variables vacías para que sepan que se tienen que configurar con un .env.

### Actualizamos el sistema y mostramos los comandos que se van ejecutando 

```
sudo apt update
sudo apt upgrade -y
```

```
set -ex
```

## Configuramos las respuestas para la instalación de phpmyadmin

```bash
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections

echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections

echo "phpmyadmin phpmyadmin/mysql/app-pass password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections

echo "phpmyadmin phpmyadmin/app-password-confirm password $PHPMYADMIN_APP_PASSWORD" | debconf-set-selections
```

>Esto se hace para que a la hora de instalar el phpmyadmin automatice todos esos procesos que se tendrian que hacer a mano como la creación de un usuario.

## 1. Instalamos phpMyAdmin

```
apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y
```

### 1.2 Creamos una base de datos de ejemplo

```
mysql -u root <<< "DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root <<< "CREATE DATABASE $DB_NAME"
```

### 1.3 Creamos un usuario para la base de datos de ejemplo

```
mysql -u root <<< "DROP USER IF EXISTS '$DB_USER'@'%'"
mysql -u root <<< "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD'"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%'"
```