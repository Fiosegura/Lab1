#Script que recibe el nombre de un archivo e imprime sus permisos.
#!/bin/bash

#Se ingresa el archivo.
echo "Inserte el nombre de un archivo REGULAR:"
read archivo

#Se busca el path del archivo por medio de find. Este lo busca independientemente del lugar en donde se ejecute el script y lo va a buscar únicamente un nuestras capetas de usuario. 
path=$(find /home/$USER -type f -name $archivo)
#Permisos del archivo almacenados en una variable
permisos=$(stat -c "%A" "$path")


#Con una estructura de control se verifica la existencia del archivo por medio de -e. Si $path está vacía, es porque no se encontró el archivo, la condición no se cumple y el código de salida sería 1, que indica error en el proceso.
if [ -e "$path" ]; then
   echo "El archivo existe: $path"
   echo "$permisos"
else
   echo "NO EXISTE. El código del proceso es: $?"
fi
