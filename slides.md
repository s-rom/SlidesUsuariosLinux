---
marp: true
# @auto-scaling: true
theme: default
class: invert
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