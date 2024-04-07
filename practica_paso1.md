# Ejercicios de permisos
## Permisos en una empresa

La situación es la siguiente: tenemos una serie de empleados (usuarios) y departamentos (grupos) en la empresa, y una serie de carpetas en el servidor (`/srv/empresa/`) que contienen los archivos relevantes para la presentación.

Los usuarios que debemos tener en cuenta son:

- dev1
- dev2
- dev3
- dev4
- qa1
- qa2
- qa3
- qa4
- admin1
- admin2
- director

Y los departamentos de la empresa son:

- Desarrollo
- Control de calidad
- Administracion
- Direccion
- Empresa

Los empleados están distribuidos en los siguientes departamentos:

| Empleado | Desarrollo | Control de Calidad | Administración | Dirección | Empresa |
|----------|------------|--------------------|----------------|-----------|---------|
| dev1     | X          |                    |                |           | X       |
| dev2     | X          |                    |                |           | X       |
| dev3     | X          |                    |                |           | X       |
| qa1      |            | X                  |                |           | X       |
| qa2      |            | X                  |                |           | X       |
| qa3      |            | X                  |                |           | X       |
| admin1   |            |                    | X              |           | X       |
| admin2   |            |                    | X              |           | X       |
| director      |            |                    |                | X         | X       |

---

### Paso 1: Organización de directorios, usuarios y grupos

### Requisitos
1. Cada empleado debe poder escribir solo en sus propios archivos.
2. Cada departamento debe poder leer los archivos de su departamento, pero no escribir en ellos.
3. El director debe poder leer todos los archivos, ya que necesita revisarlos para la presentación.
4. admin1, admin2 y director deben poder ejecutar sudo


### Trabajo:
1. Crea todas las cuentas de empleado. Asegurate de que su shell de inicio es `/bin/bash` y que todos tienen un directorio personal

2. Crea un grupo por cada departamento.

3. Crea un directorio llamado `empresa` en el directorio `/srv`
    - Dentro de `/srv/empresa` crea una carpeta para cada directorio
 
4. Cambia los grupos de cada directorio de modo que:
    - El propietario de `/srv/empresa` es **director**
    - El grupo de `/srv/empresa` es **empresa**
    - El propietario de cada directorio asociado a cada departamento es  **director**
    - El grupo de cada directorio asociado a cada departamento es el grupo correspondiente. Por ejemplo: el grupo asociado a `/srv/empresa/desarrollo` es **desarrollo**

5. Cumple con el requisito 4 añadiendo a los usuarios al grupo `sudo`.
    - Otorga sudo a admin1 y admin2 manualmente editando el fichero `/etc/group`
    - Otorga sudo a director mediante el comando `usermod`

6. Mediante el comando `chmod` realiza los cambios de permisos necesarios para que se cumplan los tres requisitos. Utiliza chmod en modo octal

7. Crea ficheros de prueba en todos los directorios.

8. Documenta la demostración práctica de que todos los requisitos se cumplen. 
