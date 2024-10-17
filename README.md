# Practica-IAW-1.1

## Instalación de Apache HTTP Server, PHP y MySQL Server en Ubuntu Server

### Paso 1: Actualizamos el sistema y mostramos los comandos que se van ejecutando

```bash
sudo apt update
sudo apt upgrade -y
```

```bash
set -ex
```

## Instalación del Servidor web Apache

```bash
apt install apache2 -y
```

### Paso 2: Habilitamos el módulo rewrite

```bash
a2enmod rewrite
```

### Paso 3: Copiamos el archivo de configuracion de apache

```bash
cp ../conf/000-default.conf /etc/apache2/sites-available
```

### Paso 4: Instalamos PHPMyAdmin
