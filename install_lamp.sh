#!/bin/bash

#Para mostrar los comandos que se van ejecutando
set -ex

#Actualizamos los repositorios
apt update

#Actualizamos los paquetes
apt upgrade

#Instalamos el serdivor web Apache
apt install apache2 -y

