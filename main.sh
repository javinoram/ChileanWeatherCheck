#!/bin/bash
function texto_menu () {
    cat << EOF
Bienvenido, selecciones un centro meteorologico:

    1) Centro Meteorológico de Iquique.
    2) Centro Meteorológico de Valparaíso.
    3) Centro Meteorológico de Talcahuano.
    4) Centro Meteorológico de Puerto Montt.
    5) Centro Meteorológico de Punta Arenas.
    6) Salir.

    Ingresa una opcion (1-6):
EOF
}


#texto_menu
seleccion=100
until [ ${seleccion} == 6 ]; do
    texto_menu

    #Mostrar texto del menu para dejar al usuario elegir
    read seleccion

    #casos segun la seleccion
    case "$seleccion" in 
        1) source weather.sh "Cenmeteoique"
        ;;
        2) source weather.sh "Cenmeteovalp"
        ;;
        3) source weather.sh "Cenmeteotalc"
        ;;
        4) source weather.sh "Cenmeteopmo"
        ;;
        5) source weather.sh "Cenmeteopar"
        ;;
        6) continue
        ;;
        *) echo "Opcion no valida"
        ;;
    esac
    clear
done