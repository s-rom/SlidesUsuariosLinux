# Comandos de gestión de usuarios
<!-- TOC tocDepth:2..3 chapterDepth:2..6 -->

    - [useradd](#useradd)
    - [passwd](#passwd)
    - [userdel](#userdel)
    - [usermod](#usermod)
    - [groupadd](#groupadd)
    - [groupdel](#groupdel)
    - [chgrp](#chgrp)
    - [chmod](#chmod)
    - [chown](#chown)

<!-- /TOC -->

### useradd
Agrega un nuevo usuario al sistema.

**Sintaxis:**
```bash
useradd [opciones] nombre_usuario
```

**Ejemplo Típico:**
```bash
useradd usuario_nuevo -m -s /bin/bash
```

**Opciones útiles:**
- `-m`: Crea automáticamente el directorio home para el nuevo usuario.
- `-s shell`: Establece un shell por defecto

---
### passwd
Cambia la contraseña de un usuario.
Pedirá introducir y confirmar una contraseña

**Sintaxis:**
```bash
passwd nombre_usuario
```

**Ejemplo Típico:**
```bash
passwd usuario
```

**Opciones útiles:**
- `--expire`: Caduca la contraseña del usuario, de modo que este deberá cambiarla cuando inicie sesión

---
### userdel

Elimina un usuario del sistema.

**Sintaxis:**
```bash
userdel [opciones] nombre_usuario
```

**Ejemplo Típico:**
```bash
userdel usuario_a_eliminar
```

**Opciones útiles:**
- `-r`: Elimina también el directorio home del usuario.

---
### usermod

Modifica las propiedades de un usuario existente.

**Sintaxis:**
```bash
usermod [opciones] nombre_usuario
```

**Ejemplo Típico:**
```bash
usermod -G grupo_nuevo usuario_existente
```

**Opciones útiles:**
- `-G grupo`: Cambia el grupo primario de un usuario.
- `-aG grupo`: Añade al usuario a un grupo adicional.
- `-L`: bloquea el inicio de sesión a un usuario.
- `-U`: desbloquea a un usuario bloqueado.

---
### groupadd

Agrega un nuevo grupo al sistema.

**Sintaxis:**
```bash
groupadd [opciones] nombre_grupo
```

---
### groupdel

Elimina un grupo del sistema.

**Sintaxis:**
```bash
groupdel [opciones] nombre_grupo
```

---
### chgrp

Cambia el grupo asociado a un archivo o directorio.

**Sintaxis:**
```bash
chgrp [opciones] nuevo_grupo archivo_o_directorio
```

**Opciones útiles:**
- `-R`: Aplica los cambios de propietario de manera recursiva en los subdirectorios.

---
### chmod

Cambia los permisos de un archivo o directorio.

**Sintaxis:**
```bash
chmod [opciones] modo archivo_o_directorio
```

**Ejemplo Típico:**
```bash
chmod u+rwx archivo.txt
```

**Opciones útiles:**
- `-R`: Aplica los cambios de permisos de manera recursiva en los subdirectorios.
- `u`: Representa al propietario del archivo.
- `g`: Representa al grupo asociado al archivo.
- `o`: Representa a otros usuarios.
- `a`: Representa a todos los usuarios (equivalente a `ugo`).

---
### chown

Cambia el propietario y/o grupo de un archivo o directorio.

**Sintaxis:**
```bash
chown [opciones] nuevo_propietario:nuevo_grupo archivo_o_directorio
```


**Opciones útiles:**
- `-R`: Aplica los cambios de propietario de manera recursiva en los subdirectorios.