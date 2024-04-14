#!/bin/bash

#Mostrar las temperaturas de la zona elegida
function temperatura () {
    #Descargar .txt y almacenarlo en memoria
    archivo=$(curl -s "$locality" )

    #Usando REGEX entraer la informacion de interes y agregando excepciones
    #en caso de que no exista la informacion buscada
    situacion=$(echo "$archivo" | grep -A 1 -m 1 -Eo "SITUACION SINOPTICA:")
    echo "######"
    #Comprueba si la cadena esta vacia
    if [ -z "$situacion" ]; then
        echo "No se encontro informacion sobre SITUACION SINOPTICA"
    else
        echo "$situacion"
    fi

    pronostico=$(echo "$archivo" | grep -A 1 -m 1 -Eo "PRONOSTICO:")
    echo "######"
    if [ -z "$pronostico" ]; then
        echo "No se encontro informacion sobre PRONOSTICO"
    else
        echo "$pronostico"
    fi

    tempmax=$(echo "$archivo" | grep -m 1 -E "TEMPERATURA MAXIMA PROBABLE: [0-9]+")
    echo "######"
    if [ -z "$tempmax" ]; then
        echo "No se encontro informacion sobre TEMPERATURA MAXIMA PROBABLE"
    else
        echo "$tempmax"
    fi

    tempmin=$(echo "$archivo" | grep -m 1 -E "TEMPERATURA MINIMA PROBABLE: [0-9]+")
    echo "######"
    if [ -z "$tempmin" ]; then
        echo "No se encontro informacion sobre TEMPERATURA MINIMA PROBABLE"
    else
        echo "$tempmin"
    fi

    echo "######"
    echo "Datos extraidos de $locality"
    echo "######"
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

#clear
menu_opciones

#Seleccion de una de las opciones
seleccion=100
parada=$(($variable))

#Ciclo para seleccionar diferentes comunas
until [ ${seleccion} == ${parada} ]; do
    read seleccion
    case $seleccion in 
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
