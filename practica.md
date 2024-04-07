# Práctica
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
| dev4     | X          |                    |                |           | X       |
| qa1      |            | X                  |                |           | X       |
| qa2      |            | X                  |                |           | X       |
| qa3      |            | X                  |                |           | X       |
| qa4      |            | X                  |                |           | X       |
| admin1   |            |                    | X              |           | X       |
| admin2   |            |                    | X              |           | X       |
| director      |            |                    |                | X         | X       |

### Paso 1: Organizando la presentación

En este primer Paso, el director está preocupado por la organización de los archivos para la presentación. Nos pide lo siguiente:


### Requisitos
1. Cada empleado debe poder escribir solo en sus propios archivos.
2. Cada departamento debe poder leer los archivos de su departamento, pero no escribir en ellos.
3. El director debe poder leer todos los archivos, ya que necesita revisarlos para la presentación.


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

5. Mediante el comando `chmod` realiza los cambios de permisos necesarios para que se cumplan los tres requisitos

6. Documenta la demostración práctica de que los tres requisitos se cumplen. 


### Paso 2: Preparando la demostración

Para el segundo Paso, el director está más relajado, pero aún necesitamos hacer algunos ajustes para la presentación:

1. Cada empleado debe poder escribir solo en sus propios archivos.
2. Cada departamento debe poder leer los archivos de su departamento, pero no escribir en ellos.
3. El director debe poder leer todos los archivos.
4. El departamento de desarrollo, en el proyecto "Saturno", necesita poder hacer anotaciones en los archivos de su departamento. Esto tiene prioridad sobre la restricción anterior.
5. En el proyecto "Inacabada", todos los archivos de los empleados cuyos nombres comiencen con la letra "**c**" deben poder ser ejecutados por "Otros".
6. En el proyecto "Valquirias", todos los archivos deben contener la frase: `El veloz murciélago hindú comía feliz cardillo y kiwi, mientras la cigüena tocaba el saxofón detrás del palenque de paja....0123456789`. Además, el director debe poder escribir en ellos.

### Paso 3: La última presentación

Para el tercer Paso, el director está muy satisfecho con nuestro trabajo, pero todavía hay algunas tareas finales antes de la presentación final:

1. Cada empleado debe poder escribir solo en sus propios archivos.
2. Cada departamento debe poder leer los archivos de su departamento, pero no escribir en ellos.
3. El director debe poder leer todos los archivos.
4. En el proyecto "Nocturnos", queremos cambiar la fecha de última modificación de todos los archivos al 01/10/1983.
5. En el proyecto "Fratres", todos los usuarios deben poder crear nuevos archivos, pero estos nuevos archivos deben pertenecer al grupo "empresa". Esto debe hacerse de forma transparente al crear los archivos, sin cambios posteriores en los permisos.
6. En el proyecto "Adagio", el director debe poder crear archivos que pertenezcan al grupo "empresa".
7. En el proyecto "DeProfundis", queremos agregar en cada archivo el identificador numérico del propietario y el identificador del grupo principal del propietario.

### Final: La gran presentación

Para la presentación final, el director necesita lo siguiente:

1. Cada empleado debe poder escribir solo en sus propios archivos.
2. Cada departamento debe poder leer los archivos de su departamento, pero no escribir en ellos.
3. El director debe poder leer todos los archivos.
4. En el proyecto "Galope", los archivos del departamento "desarrollo" deben contener los archivos de ese departamento.
5. En el proyecto "Carmina", el archivo del director debe ser la concatenación de los archivos restantes.
6. En el proyecto "1812", cada archivo de instrumentos debe contener además el historial de las órdenes ejecutadas por el propietario del archivo.

