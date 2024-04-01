#!/bin/bash
function texto_menu () {
    cat << EOF
    Bienvenido, selecciones un centro meteorologico:

    1) Centro Meteorológico de Iquique
    2) Centro Meteorológico de Valparaíso
    3) Centro Meteorológico de Talcahuano
    4) Centro Meteorológico de Puerto Montt
    5) Centro Meteorológico de Punta Arenas
    6) Salir.

    Ingresa una opcion (1-6):
EOF
}

seleccion=100
until [ ${seleccion} == 6 ]; do
    #Mostrar texto del menu para dejar al usuario elegir
    texto_menu
    read seleccion

    #casos segun la seleccion
    clear
    case "$seleccion" in 
        1) echo "opcion 1" && source weather.sh "Cenmeteoique"
        ;;
        2) echo "opcion 2" && source weather.sh "Cenmeteovalp"
        ;;
        3) echo "opcion 3" && source weather.sh "Cenmeteotalc"
        ;;
        4) echo "opcion 4" && source weather.sh "Cenmeteopmo"
        ;;
        5) echo "opcion 5" && source weather.sh "Cenmeteopar"
        ;;
        6) continue
        ;;
        *) echo "Opcion no valida"
        ;;
    esac
done