#Segunda parte del Labo1 :Limitar los permisos de ejecución del script anterior (lab1.sh)
#!bin/bash

echo "Introduzca el nuevo usuario:" 
read user
echo ""
echo "Introduzca el grupo"
read grupo

#Al buscar la variable de ambiente id sabemos si existe o no el usuario, si se encuentra existe, y sino, no. Se usa el código de salida de la búsqueda para el analisis. 
id "$user" 2>/dev/null
if [ $? -eq 0 ];then
  echo "Usuario ya existe"
else
  sudo useradd "$user"
  echo "Se creó el usuario"
fi
# Se verifica la existencia del grupo buscando el nombre del grupo en /etc/group. Y con el código de salida de verifica su existencia o no. 
grep "$grupo" /etc/group 2>/dev/null>1
if [ $? -eq 0 ];then
  echo "Grupo ya existe"
else
  sudo groupadd "$grupo"
  echo "Se creó el grupo"
fi

