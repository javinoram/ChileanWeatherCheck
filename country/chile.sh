id=0
urlparce="https://climatologia.meteochile.gob.cl/application/servicios/getDatosRecientesEma/$id?usuario=correo@correo.cl&token=apiKey_personal"

#Datos sobre las estaciones meteorologicas, regiones de chile, sus capitales y codigos de
#estaciones meteorologicas cercanas a las capitas (valores extraidos de la DGAC)
regiones=("Arica-y-parinacota" "Tarapacá" "Antofagasta" "Atacama" "Coquimbo", "Valparaíso" "Metropolitana" "O'Higgins" "Maule" "Ñuble" "Biobío" "La-Araucanía" "Los-Ríos" "Los-Lagos" "Aysén" "Magallanes")
capitales=("Arica" "Iquique" "Antofagasta" "Copiapó" "La-Serena" "Valparaíso" "Santiago" "Rancagua" "Talca" "Chillán" "Concepción" "Temuco" "Valdivia" "Puerto-Montt" "Coyhaique" "Punta-Arenas") 
codigos=("180005" "200010" "230002" "270009" "290004" "330006" "330020" "340045" "340031" "360011" "370036" "380029" "390015" "410005" "450022" "520006")

#Menu de opciones
function menu_opciones () {
    variable=0
    echo "Seleccione una region/provincia:"
    for i in ${!regiones[@]}; do
        echo "$i) ${regiones[$i]}"
        variable=$(($variable+1))  
    done
    echo "$variable) Salir." 
}


#Ciclo de seleccion para mas de una opcion
#Se crea un archivo temporal que es depues es indicado
#al llamar al script de funciones
menu_opciones

parada=$(($variable))
seleccion=100

until [ ${seleccion} == ${parada} ]; do
	read seleccion
	case $seleccion in
	${parada})
		continue
	;;
	*) if [[ ${seleccion} -gt -1 && ${seleccion} -lt $((${parada}-1)) ]]; then
	    urlparce="https://climatologia.meteochile.gob.cl/application/servicios/getDatosRecientesEma/${codigos[$((seleccion))]}?usuario=correo@correo.cl&token=apiKey_personal"
	    wget -q --no-check-certificate -O country/salida.json "$urlparce"
	    source country/functions.sh country/salida.json 
	    rm country/salida.json
	else
            echo "Opcion no valida"
	fi
	;;
esac
done
