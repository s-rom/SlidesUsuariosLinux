#!/bin/bash

dir='/home/ej1/esb'
rm -r $dir

if test $? -eq 0; then
    echo "Directorio eliminado '$dir' eliminado!"
	exit 0
else
    echo "El directorio no seha podido eliminar"
	exit 1
fi