#!/bin/bash

#Mostrar las temperaturas de la zona elegida
function temperatura () {
    temperaturas=$(curl -s $locality | grep -Eo "TEMPERATURA [A-Za-z0-9]+ [A-Za-z0-9]+: [0-9]+°C.")
    variable=1
    echo "Temperatura extraida de $locality"
    until [ ${variable} == 3 ]; do
        echo $( echo $temperaturas | awk -v var=$(($variable)) -F '.' '{print $var}' )
        variable=$(($variable+1))
    done
}

#Mostrar por pantalla las posibles opciones
function menu_opciones () {
    variable=1
    echo "Seleccione una comuna:"
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
    case $seleccion in 
        #$seleccion -gt 0 && $((${parada}-1)) -lt $seleccion )
        #    locality="$( echo $opciones | awk -v var=$(($seleccion)) -F ' ' '{print $var}' )"
        #    temperatura
        #;;
        ${parada}) 
            continue
        ;;
        *) 
            if [[ ${seleccion} -gt 0 && ${seleccion} -lt $((${parada}-1)) ]]; then
                locality="$( echo $opciones | awk -v var=$(($seleccion)) -F ' ' '{print $var}' )"
                temperatura
            else
                echo "Opcion no valida"
            fi
        ;;
    esac
done
