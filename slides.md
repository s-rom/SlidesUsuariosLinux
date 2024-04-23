---
marp: true
# @auto-scaling: true
theme: default
#class: invert
---

# Linux: Usuarios y grupos
## Permisos, bits especiales y ACL

---
* **Permisos** Establecen el nivel de acceso a un fichero o directorio de un usuario, un grupo o de todos los usuarios del sistema.

* Podemos ver los permisos ejecutando `ls -l`

<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

![w:800 center](<ls -l.png>)

1. La primera columna es una representación textual de los permisos
2. La tercera columna indica el usuario propietario del fichero o directorio (*owner*)
3. La tercera columna indica el grupo asociado al fichero o directorio (*group*)


--- 


Los permisos (primera columna) indican el nivel de acceso que tiene, en un determinado directorio o fichero: el usuario propietario, el grupo asociado y el resto de usuarios del sistema.

![w:800 center](<ls -l.png>)


* Existen tres entidades a las cuales podemos otorgar permisos sobre un fichero/directorio:

1. Al usuario propietario (**owner** = **u**)
2. Al grupo asociado (**group** = **g**)
3. Al resto de usuarios (**other** = **o**)

--- 

# Ejemplo

El fichero **program.py** tiene los permisos `-rwxrwxr-x`, el propietario es *sergi* y el grupo es *admins*.



| -       | rwx                                               | rwx                                                             | r-x                                                           |
|---------|---------------------------------------------------|-----------------------------------------------------------------|---------------------------------------------------------------|
| Fichero | Owner                                             | Group                                                           | Other                                                         |
|         | El usuario sergi puede leer, modificar y ejecutar | Los miembros del grupo admins pueden leer, modificar y ejecutar | El resto de usuarios pueden leer y ejecutar pero no modificar |

---

El primer carácter indica si se trata de un directorio (**d**) o un fichero (**-**). 

El resto de la cadena se desglosa en paquetes de tres carácteres. 

1. El primer paquete indica los permisos del propietario
2. El segundo paquete indica los permisos del grupo
3. El tercer paquete indica los permisos del resto de usuarios

--- 

# Representación octal

Los permisos de un fichero se pueden representar de manera octal mediante tres números. 

* Para ello basta con sustituir las letras por un uno y los guiones por un cero.
* La representación octal de los permisos `-rwxrwxr-x` es 775 


| -       | rwx   | rwx   | r-x   |
|---------|-------|-------|-------|
| Fichero | Owner | Group | Other |
|         | 111   | 111   | 101   |
|         | 7     | 7     | 5     |



---

# Permisos

Tienen un signficado ligeramente distinto si se establecen sobre un fichero o sobre un directorio.

| Permiso | Archivo          | Directorio       |
|---------|------------------|------------------|
| `r`     | Leer el contenido del fichero  | Listar el contenido (con `ls`)        |
| `w`     | Modificar el contenido del fichero | Crear, eliminar o modificar archivos en el directorio |
| `x`     | Ejecutar el fichero | Acceder o atravesar el directorio (necesario para cambiar a este directorio con `cd`) |

---


# Comandos de gestión de permisos y usuarios

---

## Cambio de permisos: comando `chmod`

Los únicos usuarios que pueden modificar los permisos de los archivos o directorios son:
* el usuario **root**
* el propietario del archivo o directorio
* el propietario del directorio donde están los archivos o directorios


**Sintaxis** `chmod [opciones] permisos <fichero_o_directorio>`

Para establecer los permisos podemos usar dos modos: simbólico u octal

---

## `chmod` en modo simbólico

* Se usan los carácteres **+** (añadir permiso) o **-** (quitar permiso) seguido de la letra que representa el permiso.

El siguiente comando añade el permiso de ejecución para el propietario, el grupo y el resto de usuarios.

```shell
chmod +x program.py
```

Si queremos ser más específicos, podemos usar la letra que representa a cada entidad:

```shell
chmod u+x program.py
```

Con el último comando hemos añadido el permiso de ejecución únicamente al propietario del grupo


---

## Más ejemplos

* Quitar el permiso de lectura al resto de usuarios
```shell
chmod o-x program.py
```

* Añadir permiso de modificación al grupo asociado al fichero
```shell
chmod g+w program.py
```

* Añadir permiso de lectura y escritura al propietario
```shell
chmod u+rw program.py
```


---

## Ejemplo: `chmod` en modo octal

* Se usa cuando queremos establecer todos los permisos de golpe. 

Tenemos el siguiente fichero: 

```shell
sergi@server~$ ls -l file.txt 
-r--r--r-- 1 sergi admins 75 abr  7 14:59 file.txt
```

Queremos establecer los permisos de modo que:

* El propietario pueda leer, escribir y ejecutar el fichero (`rwx`)
* Los miembros del grupo puedan leer y ejecutar pero no modificar (`r-x`)
* El resto de usuarios del grupo puedan únicamente leer el fichero (`r--`)





---

Primero calculamos los permisos en modo octal equivalentes a los deseados 
(`rwxr-xr--`)

|                        | Propietario | Grupo | Resto |
|------------------------|-------------|-------|-------|
| Permisos esperados     | rwx         | r-x   | r--   |
| Representación binaria | 111         | 101   | 100   |
| Representación octal   | 7           | 5     | 4     |

&rarr; Los permisos en octal son `754`

```shell
sergi@server~$ chmod 754 file.txt 
-rwxr-xr-- 1 sergi admins 75 abr  7 14:59 file.txt
```



---
# Cambiar el propietario 
## Comando `chown`

El siguiente comando cambia el propietario actual de file.txt al usuario juan

```shell
sergi@server~$ chown juan file.txt 
-rwxr-xr-- 1 juan admins 75 abr  7 14:59 file.txt
```

---
# Cambiar el grupo
## Comando `chgrp`

El siguiente comando cambia el grupo actual de file.txt al grupo alumnos

```shell
sergi@server~$ chgrp alumnos file.txt 
-rwxr-xr-- 1 juan alumnos 75 abr  7 14:59 file.txt
```

---

# Root

* El usuario **root** es un usuario privilegiado que puede acceder a cualquier recurso independientemente de los permisos

* Siempre viene creado por defecto y no tiene contraseña

    - Es aconsejable no iniciar sesión en una máquina linux con el comando root


--- 

# Forzar la ejecución
## Comando `sudo`

Si delante de cualquier comando escribimos `sudo`, el comando se ejecutará como si lo estuviera ejecutando otro usuario. 

* Solo los usuarios que pertenecen al grupo `sudo` pueden usar el comando `sudo` (en general)

* Por defecto, `sudo` ejecuta el comando como el usuario `root`
    - Esto implica que en la mayoría de casos, el comando `sudo` es usado por administradores para forzar la ejecución de un comando independientemente de los permisos.

---

# Ejemplo sudo

Cuando un usuario crea un fichero, se establece automáticamente como el propietario de este:

```shell
sergi@server~$ touch fichero.txt 
-rw-rw-r-- 1 sergi sergi 0 abr  7 16:04 fichero.txt
```

Si ejecutamos el mismo comando usando `sudo`, es como si el comando en si lo estuviera ejecutando el usuario **root**

```shell
sergi@server~$ sudo touch fichero2.txt 
-rw-r--r-- 1 root  root  0 abr  7 16:05 fichero2.txt
```



--- 

# Ejemplo sudo: otro usuario

Podemos usar la opción `-u` para ejecutar cualquier comando como si lo estuviera haciendo otro usuario a parte de root


```shell
sergi@server~$ sudo -u juan touch fichero3.txt
-rw-r--r-- 1 juan  juan  0 abr  7 16:05 fichero3.txt
```

---

# Ejemplo sudo: evitar permisos

El caso más típico de sudo es cuando necesitamos saltarnos los permisos para un comando en específico. 

**Ejemplo:**

```shell
sergi@server~$ ls -l fichero3.txt
-rw-rw---- 1 juan  juan  5 abr  7 16:05 fichero3.txt
```
Según los permisos, únicamente *juan* puede leer **fichero3.txt**

Si intento leer el fichero con `cat` el sistema me dará un error.


```shell
sergi@server~$ cat fichero3.txt
cat: fichero3.txt: Permission denied
```

---

Si usamos el comando `sudo`:


1. Ejecutamos el comando `cat fichero3.txt` como el usuario root
2. El usuario root puede ejecutar cualquier comando independientemente de los permisos

```shell
sergi@server~$ cat fichero3.txt
cat: fichero3.txt: Permission denied
```

--- 

# Cambiar de usuario
## Comando su

Permite cambiar de usuario

* Nos pedirá la contraseña del usuario
    - Es decir, si el usuario no tiene contraseña no podremos cambiar de usuario
    - Debemos conocer la contraseña del usuario


```shell
sergi@server~$ su juan
Password:
juan@server/home/sergi$
```

El usuario ha cambiado (como se observa en el prompt) pero el directorio actual sigue siendo el directorio personal del usuario sergi.

---

Si escribimos un guión entre `su` y el nombre, se hará un login "limpio". Es decir, será como si el usuario *juan* iniciase sesión de cero. 

* Esto se debe a que el guión le indica al comando su que reestablezca las variables de entorno

```shell
sergi@server~$ su - juan
Password:
juan@server~$
```

---

# Forzar el cambio de usuario

Si nuestro usuario tiene permisos de sudo (es *sudoer*) podemos forzar el cambio de usuario sin conocer la contraseña o si el usuario aún no tiene una contraseña asignada

```shell
sergi@server~$ sudo su - juan
juan@server~$
```

En este caso, no me ha pedido la contraseña del usuario *juan*

---

Podemos incluso forzar el cambio de usuario a root

```shell
sergi@server~$ sudo su - root
root@server:~#
```

* Esta operación es muy peligrosa dado que podemos modificar o eliminar cualquier fichero o directorio del sistema (entre otras cosas)

* Una vulnerabilidad típica en un sistema Linux se produce cuando una aplicación consigue acceso al usuario root (de un modo u otro)


--- 

# Archivos de configuración

En el directorio `/etc` se almacenan los archivos de configuración de los distintos sistemas. 

En el caso de los usuarios y grupos:

* El fichero `/etc/passwd` almacena la información de los usuarios
* El fichero `/etc/group` almacena la información de los grupos
* El fichero `/etc/shadow` almacena las contraseñas de los usuarios encriptadas
* El fichero `/etc/gshadow` almacena las contraseñas de los grupos encriptadas

---

# /etc/passwd

Cada línea contiene los atributos de un usuario separados por dos puntos (**:**) 

```shell
sergi@server~$ tail /etc/passwd
tcpdump:x:109:115::/nonexistent:/usr/sbin/nologin
tss:x:110:116:TPM software stack,,,:/var/lib/tpm:/bin/false
landscape:x:111:117::/var/lib/landscape:/usr/sbin/nologin
fwupd-refresh:x:112:118:fwupd-refresh user,,,:/run/systemd:/usr/sbin/nologin
usbmux:x:113:46:usbmux daemon,,,:/var/lib/usbmux:/usr/sbin/nologin
sergi:x:1000:1000:sergi:/home/sergi:/bin/bash
lxd:x:999:100::/var/snap/lxd/common/lxd:/bin/false
usB:x:1001:1001::/home/usB:/bin/bash
usA:x:1002:1002::/home/usA:/bin/bash
juan:x:1003:1004::/home/juan:/bin/bash
```

El formato de cada linea es: `username:password:uid:gid:gecos:dir:shell`

---

## Campos de `/etc/passwd`
* **username**:  nombre de usuario
* **password**:  carácter x indicando que la contraseña está encriptada en `/etc/shadow`
* **uid**:  user id
* **gid**:  primary group id
* **gecos (opcional)**:  para almacenar comentarios a cerca del usuario
* **dir**:  valor de la variable `$HOME` (directorio personal)
* **shell**:  path del shell, por defecto `/bin/bash`

---

# /etc/shadow

Las contraseñas se guardan en el archivo `/etc/shadow`, al que sólo tiene acceso el usuario administrador (permisos 600) y están encriptadas con MD5 o DES. 

MD5 es un método más fuerte de encriptación.

---

# Jerarquía de grupos

* Todos los usuarios pertenecen a un grupo principal y (opcionalmente) a varios grupos secundarios. 

* Cuando creamos un usuario, por defecto se crea un grupo principal con el mismo nombre (y el mismo id) y se le asigna como grupo principal


--- 

# /etc/group

Cada línea representa un grupo siguiendo el formato: `groupname:password:gid:members`

```shell
sergi@server:~$ tail /etc/group
uuidd:x:114:
tcpdump:x:115:
tss:x:116:
landscape:x:117:
fwupd-refresh:x:118:
sergi:x:1000:
usB:x:1001:
usA:x:1002:
admins:x:1003:
juan:x:1004:
```

En /etc/shadow solo aparecen los miembros secundarios. Si queremos añadir un usuario a un grupo, lo más sencillo es modificar el fichero /etc/group

---

# Ejemplo: añadir un usuario a un grupo

Queremos añadir el usuario *juan* al grupo *sudo* para que *juan* pueda ejecutar el comando `sudo`

Para ello, basta modificar el fichero `/etc/group` y añadir a *juan* a la lista de miembros (por ejemplo con el editor `nano` o `vim`).

El resultado final sería este:

```shell
sergi@server~$ grep 'sudo' /etc/group
sudo:x:27:sergi,juan
```

---

# Bits speciales

* Se trata de permisos especiales para casos más concretos

    - **SUID** (special user id) 
    - **SGID** (special group id)
    - **Sticky bit**

---

# SUID

* Bit especial de *propietario*
* Identificado por la letra **s**

Un fichero ejecutable con el bit **s** activado se ejecuta con los permisos del propietario del fichero


--- 

# GUID

Es exactamente lo mismo que el bit SUID pero en este caso hace referencia al grupo de un fichero en lugar del propietario

---

# SUID: Ejemplo

El comando `solucion` es un fichero ejecutable (programa) que compara la solución de un usuario a un ejercicio con la solución correcta.

* La solución correcta debe estar almacenada en el servidor. En concreto, la solución está en el directorio /.secret

```shell
sergi@server~$ ls -l /.secret
total 4
-rw-r--r-- 1 root root 2468 abr 15 19:23 ExamenISO_grep_sed.txt
```

---

```shell
sergi@server~$ ls -l /.secret
total 4
-rw-r--r-- 1 root root 2468 abr 15 19:23 ExamenISO_grep_sed.txt
```

Este fichero contiene la solución al examen y como podemos ver por los permisos, todos los alumnos podrían simplemente leer el fichero. 

Para ello, podriamos pensar que basta con quitar el permiso de lectura para evitar que los alumnos lean el examen

```shell
sergi@server~$ chmod o-r /.secret/ExamenISO_grep_sed.txt
```
---

Pero ahora hemos creado otro problema. Al ejecutar `solucion` nos salta este error:

```python
PermissionError: [Errno 13] Permission denied: '/.secret/ExamenISO_grep_sed.txt'
```


1. Estamos ejecutando el comando `solucion` con los permisos de nuestro usuario
2. El comando `solucion` intenta leer la solución del examen
3. Como no tenemos permisos de lectura en ese fichero, el comando tampoco lo tiene


---

# Solución: Añadir el bit SUID

```shell
sergi@server~$ chmod u+s /usr/bin/solucion
sergi@server~$ ls -l /usr/bin/solucion
sergi@server~$ ls -l /.secret
total 4
-rw-r----- 1 root root 2468 abr 15 19:23 ExamenISO_grep_sed.txt
sergi@server/usr/bin$ ls -l solucion
-rwsr-xr-x 1 root root 897048 abr 15 19:23 solucion
```

**Observación:** **x** del apartado del propietario se ha cambiado por una **s**

* Ahora, cualquier usuario que ejecute el comando `solucion`, lo ejecutará con los permisos del propietario (que en este caso es `root`)

* El resto de usuarios ya no puede leer el fichero de la solución


---

# Vulnerabilidad

Pese a que hemos conseguido el comportamiento esperado hemos creado una gran vulnerabilidad en el sistema.


* El comando `solucion` ejecuta las soluciones de los alumnos
* Al tener el bit SUID, ejecuta las soluciones de los alumnos con privilegios de `root`
* Se puede abusar este comportamiento para ejecutar comandos con privilegios de `root` poniendo lo que queramos ejecutar con la sintaxis: 

```
1) Enunciado
Solucion: ...
```


--- 

# Vulnerabilidad

Por suerte, evitar esto es simple. 

1. Creamos un usuario especial llamado `solve`
2. El usuario `solve` es propietario de la solución correcta y solo el puede leerla
3. El usuario `solve` es propietario del fichero del comando `solucion`
4. Añadimos el bit SUID al comando `solucion`


---

```shell
sergi@server~/ExamenISO_grep_sed$ ls -l /usr/bin/solucion
-rws--x--x 1 solve solve 897048 abr 15 19:23 /usr/bin/solucion


sergi@server~/ExamenISO_grep_sed$ ls -l /.secret/ExamenISO_grep_sed.txt
-rw------- 1 solve solve 2468 abr 15 19:23 /.secret/ExamenISO_grep_sed.txt
```


* Ahora no hay peligro para el sistema dado que el usuario `solve` no tiene más privilegios a parte de leer el fichero

* Este patrón es muy usado en diversos servicios Linux

--- 

# Peculiaridades

* Linux ignora el SUID y el GUID en *scripts*
* Si añadimos el SUID o el GUID a un fichero sin permiso de ejecución veremos el permiso con una **S** mayúscula


---

# SUID y GUID en directorios

* Si un directorio tiene establecido el bit GUID, los ficheros y directorios creados heredan el mismo grupo que el directorio. 


* En algunos sistemas Linux, el bit SUID en directorios funciona de manera similar. (En Ubuntu Server funciona así)

---

# Sticky bit 

* Identificado por la letra **t**


* Cuando se le asigna a un directorio, significa que los elementos que hay en ese directorio sólo pueden ser renombrados o borrados por:
    - el propietario del elemento
    - el propietario del directorio
    - el usuario root
    
&rarr; Aunque el resto de usuarios tenga permisos de escritura y, por tanto, pueda modificar el contenido de esos elementos.


**Ejemplo**
```shell
sergi@server~$ chmod +t directorio/
```


--- 

# Bits especiales: modo absoluto

Para establecer los bits especiales también podemos utilizar el modo octal/absoluto de `chmod`

Se añade un digito octal a la izquierda codificado como:

| SUID | SGID | STICKY |
|------|------|--------|

---

**Ejemplo**
Queremos configurar un directorio donde:

* El propietario puede leer, escribir y ejecutar (`rwx` = 7)
* Los miembros del grupo pueden leer y ejecutar (`r-x` = 5)
* El resto de usuarios no pueden hacer nada (`---` = 0)
* Los ficheros y directorios creados dentro de este heredan el grupo del directorio (`SGID`)


| SUID | SGID | STICKY |
|------|------|--------|  
| 0    | 1    |  0     |


```shell
sergi@server~$ chmod 2750 directorio/
```



---



# ACL
## Access Control List


---

# ACL

Permite definir permisos más granulares y concretos

Podemos instalar esta herramienta mediante:

```shell
sergi@server~$ sudo apt install acl
```

--- 

# Ver permisos

```shell
sergi@server/data$ getfacl .
```

```bash
# file: .
# owner: sergi
# group: sergi
user::rwx
group::rwx
other::rwx
```

---

# Permisos explícitos

Podemos añadir permisos concretos para un determinado grupo o usuario usando el modificador `-m`


```shell
sergi@server/data$ sudo setfacl -m "u:kal:rw" main.c
```

```shell
sergi@server/data$ sudo  getfacl main.c
```
```bash
# file: main.c
# owner: sergi
# group: desarrollo
user::rw-
user:kal:rw-
group::rw-
mask::rw-
other::r--
```


--- 


# Permisos por defecto

* Los permisos por defecto se aplican a un **directorio**

* Determinan los permisos que *heredarán* los ficheros y directorios creados a partir de este

* Se establecen utilizando el modificador `-d`


---


# Ejemplo

```shell
sergi@server/data$ ls -l
total 4
drwxrwx---  2 sergi desarrollo 4096 abr 22 19:52 build
-rw-rw-r--+ 1 sergi desarrollo    0 abr 22 19:33 main.c
```

Queremos añadir una excepción para que los miembros del grupo `management` puedan acceder, crear carpetas y ficheros en el directorio build.


---

Podríamos suponer que basta con ejecutar el siguiente comando

```shell
sergi@server/data$ setfacl -m "g:management:rwx" build
```

Si miramos los permisos, efectivamente es así:

```shell
sergi@server/data/build$ getfacl .
```
```bash
# file: .
# owner: sergi
# group: desarrollo
user::rwx
group::rwx
group:management:rwx
mask::rwx
other::---
```


---

Ahora bien, si creamos una nueva carpeta dentro de `/data/build`, esta no ha heredado los permisos y por tanto el grupo `management` no puede acceder a la subcarpeta.

```shell
sergi@server/data/build/x86$ getfacl .
```
```bash
# file: .
# owner: sergi
# group: sergi
user::rwx
group::rwx
other::r-x
```

--- 

Para asegurar la herencia, debemos usar el modificador `-d`


```shell
sergi@server/data/build$ sudo setfacl -dm "g:management:rwx" .
sergi@server/data/build$ getfacl .
# file: .
# owner: sergi
# group: desarrollo
user::rwx
group::rwx
group:management:rwx
mask::rwx
other::---
default:user::rwx
default:group::rwx
default:group:management:rwx
default:mask::rwx
default:other::---
```




