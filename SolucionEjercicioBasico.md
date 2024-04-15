# Parte 1 - Creación de la estructura

```shell
mkdir /DatosEmpresa
mkdir /DatosEmpresa/marketing
mkdir /DatosEmpresa/rrhh
mkdir /DatosEmpresa/desarrollo

echo politicas > /DatosEmpresa/marketing/politicas.txt 
echo empleados > /DatosEmpresa/rrhh/lista_empleados.txt
echo reporte1 > /DatosEmpresa/desarrollo/reporte1.txt
echo reporte2 > /DatosEmpresa/desarrollo/reporte2.txt
```

**Resultado:**
```shell
sergi@server~$ sudo tree /DatosEmpresa/
/DatosEmpresa/
├── desarrollo
│   ├── reporte1.txt
│   └── reporte2.txt
├── marketing
│   └── politicas.txt
└── rrhh
    └── lista_empleados.txt

```

---

# Parte 2: Creación de grupos y usuarios

Creación de los cuatro grupos

```shell
sudo groupadd marketing
sudo groupadd rrhh
sudo groupadd desarrollo
sudo groupadd empresa
```

Creación de los usuarios

```shell
sudo useradd alen -m -s /bin/bash
sudo passwd alen # Nos pedirá que introduzcamos una contraseña para el usuario alen

# Repetimos para el resto de usuarios
sudo useradd jon -m -s /bin/bash
sudo passwd jon

sudo useradd guts -m -s /bin/bash
sudo passwd guts

sudo useradd hornet -m -s /bin/bash
sudo passwd hornet

sudo useradd kal -m -s /bin/bash
sudo passwd kal

sudo useradd syl -m -s /bin/bash
sudo passwd syl
```


A continuación establecemos el grupo principal de cada usuario (tres usando `usermod` y tres modificando `/etc/passwd`)

* Versión con `usermod`:

```shell
sudo usermod -g marketing jon
sudo usermod -g marketing alen

sudo usermod -g desarollo guts
```

* Versión modificando `/etc/passwd`:

Para ello primero necesitamos conocer el ID de los grupos **desarollo** y **rrhh**. Para ello podemos abrir el fichero `/etc/group` o directamente buscar el grupo con `grep` 

```shell
sergi@server:~$ grep 'desarrollo' /etc/group
desarrollo:x:1010:

sergi@server:~$ grep 'rrhh' /etc/group
rrhh:x:1008:
```

El id de **desarollo** es 1010 y el de **rrhh** es 1008. A continuación abrimos el fichero `/etc/passwd` con un editor y modificamos el valor de la cuarta columna (id del grupo principal).

Quedaría tal que así:

```shell
hornet:x:1004:1010::/home/hornet:/bin/bash
kal:x:1005:1008::/home/kal:/bin/bash
syl:x:1006:1008::/home/syl:/bin/bash
```




