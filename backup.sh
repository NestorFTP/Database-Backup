#!/bin/sh
#Asignación de rutas y acrónimos en las variables
timestamp="$(date '+%d-%m-%Y')"
filename=DB_BCKP_"$timestamp".sql.gz
cd "/tmp/"
mkdir $timestamp
backupfolder="/tmp/$timestamp/"
fullpath="$backupfolder$filename"
logfile="$backupfolder"LOG_DB_BCKP"$timestamp".txt

#Inicio del registro de Logs
echo "Inicio de Resapldo: $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"

#Creación del archivo que contiene el respaldo de la base de datos
mysqldump --user=usuario --password=contrasena --default-character-set=utf8 base_de_datos | gzip > "$fullpath"

#Fin del Registro de Logs del Proceso de Respaldo
echo "Término del Respaldo: $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"

#Cambio de permisos sobre los archivos creados
chown root "$fullpath"
chown root "$logfile"
echo "Permisos de los Archivos de Respaldo Modificados" >> "$logfile"
echo "Operación Finalizada: $(date +'%d-%m-%Y %H:%M:%S')" >> "$logfile"
echo "***********************************" >> "$logfile"
mail -s "Backup Database" -A "$fullpath" -A "$logfile" tu_correo@gmail.com < /tmp/body.txt
exit 0
