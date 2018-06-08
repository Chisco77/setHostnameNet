#!/bin/bash

encontrado="foo"
interfaz=0

# buscar interfaz de red que está dado de alta en ldap
while [ $encontrado == "foo" ];do
	nombre=""
	#obtener mac eth
	mac=`ip link show dev eth$interfaz | awk ' /link\/ether/ { print $2 }'`
	#obtener hostname de lista
	echo $mac
	nombre=`cat HostnamesMac.csv | grep $mac | cut -f 1`
	echo $nombre

	if [ -n "$nombre" ]; then
		encontrado="yes"
	fi

	interfaz=$(($interfaz+1))
done

#establecer nuevo hostname de la maquina
hostname $nombre

# restaurar 70-persistent-net
cp ./backup70pers/$nombre/70-persistent-net.rules /etc/udev/rules.d/70-persistent-net.rules

# restaurar rc.local
#sed -i '/setHostnamePortatiles.sh/d' /etc/rc.local
