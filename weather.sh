#!/bin/bash

#Mostrar las temperaturas de la zona elegida
function temperatura () {
    temperaturas=$(curl -s $locality | grep -Eo "TEMPERATURA [A-Za-z0-9]+ [A-Za-z0-9]+: [0-9]+°C.")
    variable=1
    until [ ${variable} == 3 ]; do
        echo $( echo $temperaturas | awk -v var=$(($variable)) -F '.' '{print $var}' )
        variable=$(($variable+1))
    done
}

#Mostrar por pantalla las posibles opciones
function menu_opciones () {
    variable=1
    for i in $opciones; do
        cadena=$(echo $i | grep -Eo "[A-Za-z0-9]+.txt")
        echo "$variable) ${cadena::$(( ${#cadena}-6 ))}."
        variable=$(($variable+1))  
    done
    echo "$variable) Salir." 
}

#Lectura del centro meteorologico elegido
centro=$1
url="http://web.directemar.cl/met/jturno/PRONOSTICOS/$centro/72/[A-Za-z0-9]+.txt"
#Extraccion de las localidades disponibles
opciones=$(curl -s https://web.directemar.cl/met/jturno/indice/index.htm | grep -Eo "$url")
clear
menu_opciones

#Seleccion de una de las opciones
seleccion=100
parada=$(($variable))

#Ciclo para seleccionar diferentes comunas
until [ ${seleccion} == ${parada} ]; do
    read seleccion
    case "$seleccion" in 
        [1-$((${parada}-1))]) 
            locality="$( echo $opciones | awk -v var=$(($seleccion)) -F ' ' '{print $var}' )"
            temperatura
        ;;
        ${parada}) 
            continue
        ;;
        *) 
            echo "Opcion no valida"
        ;;
    esac
done

