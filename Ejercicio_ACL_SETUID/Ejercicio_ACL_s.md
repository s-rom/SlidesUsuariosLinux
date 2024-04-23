# Ejercicio: Bits especiales y ACL



**Script de creación del usuario:**
```
https://raw.githubusercontent.com/s-rom/SlidesUsuariosLinux/master/Ejercicio_ACL_SETUID/create_user.sh
```



1.- El script `create_user.sh` creará un nuevo usuario llamado ej1 (contraseña = 123) en tu sistema. Debes cambiar sus permisos para convertirlo en un archivo ejecutable. El script dej1 eliminará al usuario llamado ej1. Debes cambiar sus permisos para convertirlo en un archivo ejecutable. Ambos deben ejecutarse usando el comando sudo. Comprueba si se ha creado un nuevo usuario llamado ej1 en tu sistema.

2.- Utilizando el comando `su -`, conviértete en el usuario ej1. Crea una nueva carpeta llamada `esb` en su directorio personal.

3.- Como usuario ej1, intenta eliminar `esb` ¿Puedes eliminar `esb`? ¿Por qué?

4.- Crea otra vez la carpeta llamada `esb` Utilizando el comando exit, conviértete otra vez en tu usuario "por defecto". Intenta eliminar **/home/ej1/esb**. ¿Puedes eliminar esa carpeta? ¿Por qué?


5.- Estando como usuario ej1 y usando el programa curl, descarga el código del programa `delete_dir.c` en la carpeta personal de ej1. Compila usando el comando `gcc delete_dir.c -o delete_dir`. Este programa únicamente trata de eliminar la carpeta **/home/ej1/esb** (siempre que tengas los permisos adecuados). Como usuario ej1, comprueba que puedes eliminar **/home/ej1/esb** usando `delete_dir`. Crea otra vez la carpeta `esb`


```shell
ej1@server~$ curl  https://raw.githubusercontent.com/s-rom/SlidesUsuariosLinux/master/Ejercicio_ACL_SETUID/delete_dir.c > delete_dir.c

ej1@server~$ gcc delete_dir.c -o delete_dir
```


6.- Descarga también el script `script_delete_dir` y comprueba que tiene la misma funcionalidad que `delete_dir`

```shell
ej1@server~$ curl  https://raw.githubusercontent.com/s-rom/SlidesUsuariosLinux/master/Ejercicio_ACL_SETUID/delete_dir.sh > script_delete_dir
```



7.- Instala los comandos `delete_dir` y `script_delete_dir` copiando los ficheros correspondientes a **/usr/bin/**. ¿Te deja hacerlo? ¿Por qué?

8.- Conviértete en tu usuario "por defecto" y añade una excepción acl para que el usuario ej1 pueda copiar ficheros en **/usr/bin/** únicamente.

9.- Cambia al usuario ej1 y copia ambos scripts al directorio **/usr/bin/** para instalarlos. 

10.- Intenta usar ambos comandos con tu usuario "por defecto". Argumenta por qué no se está borrando la carpeta `esb` del directorio home de ej1

11.- Como usuario ej1, añade el bit setuid a ambos programas usando el modo simbólico (`u+s`). Comprueba si el bit setuid ha sido establecido. 

12.- Conviértete otra vez en tu usuario "por defecto" y ejecuta `delete_dir` y `script_delete_dir`. Cada vez que ejecutes un comando, cambia al usuario ej1 y crea la carpeta `esb` de nuevo ¿Puedes eliminar la carpeta `esb` con ambos comandos? ¿Por qué?

13.- Como usuario ej1, borra el bit setuid de `delete_dir` usando el modo simbólico. Comprueba si el bit setuid ha sido borrado.

14.- Conviértete en tu usuario "por defecto". Intenta cambiar tu contraseña usando el comando passwd. ¿Puedes cambiar tu contraseña?

15.- Como usuario root, borra el bit setuid del comando passwd. Conviértete en tu usuario "por defecto" y trata de cambiar tu contraseña. Ahora, ¿puedes cambiar tu contraseña? ¿Por qué?

16.- Como usuario root, establece el bit setuid del comando passwd.
