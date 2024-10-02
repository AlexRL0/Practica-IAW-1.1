#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -ex

#Actualizamos los repositorios
apt update

#Actualizamos los paquetes
apt upgrade -y

#Instalamos el serdivor web Apache
apt install apache2 -y

# Habilitamos el módulo rewrite
a2enmod rewrite

#Hacemos un restart al servicio de apache para aplicar los cambios
systemctl restart apache2