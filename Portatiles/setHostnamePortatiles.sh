#!/bin/bash

#obtener mac eth0
mac=`ip link show dev eth0 | awk ' /link\/ether/ { print $2 }'`

#obtener hostname de lista
nombre=`cat HostnamesMac.csv | grep $mac | cut -f 1`

#establecer nuevo hostname de la maquina
hostname $nombre

# restaurar rc.local
sed -i '/setHostnamePortatiles.sh/d' /etc/rc.local
