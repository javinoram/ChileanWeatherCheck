#!/bin/bash
function texto_menu () {
    cat << EOF
Bienvenido, selecciona un país:

    1) Chile.
    2) Argentina.
    3) Salir.

    Ingresa una opcion (1-3):
EOF
}


seleccion=100
exitval=3

until [ ${seleccion} == ${exitval} ]; do
    texto_menu

    read seleccion

    #casos segun la seleccion
    case "$seleccion" in 
        1) source country/chile.sh
        ;;
        2) source country/argentina.sh 
        ;;
        3) continue
        ;;
        *) echo "Opcion no valida"
        ;;
    esac
done
