# Practica-IAW-1.1- Instalación de Apache HTTP Server, PHP y MySQL Server en Ubuntu Server

## Pasos previos a la instalación

**para la instalación vamos a tener que crear la siguiente estructura de directorios y archivos:**

![](imagenes/directorio.png)

**Una vez creados los archivos y directorios, procedemos a la instalación de las herramientas.**

## Instalación de Apache HTTP Server, PHP y MySQL Server en Ubuntu Server

## 1. Archivo `install_lamp.sh` para la automatización del proceso de instalación

### Paso 1: Actualizamos el sistema y mostramos los comandos que se van ejecutando. 

```
sudo apt update
sudo apt upgrade -y
```

```
set -ex
```

## Instalación del Servidor web Apache

```
apt install apache2 -y
```

### Paso 2: Habilitamos el módulo rewrite

```
a2enmod rewrite
```

### Paso 3: Copiamos el archivo de configuracion de apache

```
cp ../conf/000-default.conf /etc/apache2/sites-available
```

> [!IMPORTANT]  
> El archivo `000-default.conf` tiene que quedar como en la imagen
>![](imagenes/directorio.png)


### Paso 4: Instalamos PHPMyAdmin
