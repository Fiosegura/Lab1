#Segunda parte del Labo1 :Limitar los permisos de ejecución del script anterior (lab1.sh)
#!bin/bash

#Al buscar la variable de ambiente id sabemos si existe o no el usuario, si se encuentra existe, y sino, no. Se usa el código de salida de la búsqueda para el analisis. 

echo "Introduzca el nuevo usuario:" 
read user
id "$user" 2>/dev/null>1
if [ $? -eq 0 ];then
  echo " "
  echo "Usuario ya existe"
  echo""
else
  sudo useradd -m "$user"
  echo ""
  echo "Se creó el usuario"
  echo ""
fi
# Se verifica la existencia del grupo buscando el nombre del grupo en /etc/group. Y con el código de salida de verifica su existencia o no. 
echo "Introduzca el grupo"
read grupo
grep "$grupo" /etc/group 2>/dev/null>1
if [ $? -eq 0 ];then
  echo ""
  echo "Grupo ya existe"
  echo""
else
  sudo groupadd "$grupo"
  echo ""
  echo "Se creó el grupo"
  echo ""
fi
# Se agrega el usuario actual y el nuevo al grupo.
sudo usermod -aG $grupo $USER
sudo usermod -aG $grupo $user

#Lo puede ver en la siguiente lista
echo ""
echo "Puede buscar el grupo y verificarlo aqui:" 
echo ""
cat /etc/group

#Se cambian los permisos para que sólo el grupo tenga acceso. Nosotros también lo tendríamos al ser parte del grupo.
sudo chmod u+x lab1.sh 
sudo chmod o-x lab1.sh
sudo chmod g+x lab1.sh
#Se cambia el grupo del archivo, por el grupo creado
sudo chown :"$grupo" lab1.sh
