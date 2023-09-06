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
   echo ""
   echo "El archivo existe: $path"
   echo ""
   echo "Los permisos son: $permisos"
   echo ""
   get_permissions_verbose() {
     user=$(echo "$permisos" | cut -c 2-4)
     group=$(echo "$permisos" | cut -c 5-7)
     others=$(echo "$permisos" | cut -c 8-10)
     echo "USUARIO: $user"
     echo "GRUPO: $group"
     echo "OTROS: $others"
    }
#Aquí se llama a la función
get_permissions_verbose

#Estructura de control para revisar cada uno de los caracteres de $permisos
for  ((i=1; i<10; i++)) ; do
 caracter=$(echo "$permisos" | cut -c "$((i+1))")   	

#Títulos de los permisos 
if (( i == 1 )) ;then
    echo "  
  
  "
  echo "Desglose de permisos USUARIO:"
fi
if (( i == 4)) ;then
  echo "  
  
  "
  echo "Desglose de permisos GRUPO: "
fi
if (( i == 7 )) ;then
  echo "  
  
  "
  echo "Desglose de permisos OTROS: "
fi


#Estructura de control para determinar cual permiso es cada caracter, o si no posee permiso. 
if [ "$caracter" = "r" ]; then
 echo "Permisos de lectura"
#else
# echo "Sin permisos de lectura"
#fi
elif [ "$caracter" = "w" ]; then
  echo "Permisos de escritura"
#else
#  echo "Sin permisos de escritura"
#fi
elif [ "$caracter" = "x" ]; then
  echo "Permisos de ejecución"
else 
  echo "Sin permisos"
fi       
done

else
   echo "NO EXISTE. El código del proceso es: $?"
fi

