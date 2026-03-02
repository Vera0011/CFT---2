# Máquina de ejemplo de retos de hacking en docker-compose

Esta máquina tiene un sanity check WEB, el reto en si es símplemente un reto de ejemplo en el que al cargar la WEB te da la flag de la máquina.
También se ha habilitado el servidor ssh, no para usarse en el reto de esta máquina, si no como ejemplo de que se pueden ejecutar varios servicios y de como hacerlo.

# Información sobre el docker compose

Para utilizar la máquina deberemos situarnos en el directorio donde está leyedo este documento.

Scripts de máquinas:
* Antes de construir la máquina se debe ejecutar **prepare.sh**, tiene como parámetros el nombre de la máquina, el puerto interno y el puerto externo. En caso de no pasarle nada tomará los por defecto.
* Para iniciar la máquina de prueba ejecutar **start.sh** y ya la podrá usar. Este ejemplo tiene un servidor web con una flag. Si no ha cambiado los parámetros por defecto se puede acceder en http://127.0.0.1:8080
* Para parar la máquina de prueba, ejecutar **stop.sh**
* Para borrar del sistema la máquina de prueba, ejecutar **remove.sh**
* Se generan un archivo **.env** y **dockername.txt** para obtener los puertos y el nombre de la máquina configurados. Se pueden borrar con **clearenv.sh**

# archivo dockercompose.yml

* En el archivo docker-compose.yml hay una definición de un sistema compuesto por una máquina. Si el sistema que se está haciendo necesita de mas de una máquina, deberán añadirse máquinas.

* Todas las máquinas se incorporarán en la misma red, el sistema predefinido está preparado para compartir el puerto PORTIN de la máquina en el PORTOUT de la máquina host.

## Preparación de cada maquina particular (machine)

Existe un directorio machine/src con dos archivos:
* execute.sh: Es el script que se va a ejecutar cuando se ponga en marcha la máquina. Deberá iniciar los servidores y quedarse en un bucle infinito.
* prepare.sh: Es el script que instala todos los programas necesarios en la máquina y prepara el sistema. Ahi estan acciones como apt install o cambios en los archivos de configuracion necesarios para crear la máquina.

## Flags

Por defecto el sistema está puesto para que se comparta la flag del directorio **./flag/** llamada **flag.txt**

## Documentacion

En el directorio **./docs** se pondrán los documentos para entregar, el write up y la documentación adicional necesaria como descripción de la maquina, es decir lo que se da de descripcion de reto a los que la deseen utilizar.

En el directorio **./solution/** se debería poner un solve.sh que realize todas las operaciones necesarias para obtener la flag de la maquina realizando todo el proceso que realizaría quien la desea solentar. No se deberia utilizar información privilegiada, si el participante tiene que pasearse por un diccionario entero, este script debe de realizarlo también.
