#Ciudades y regiones argentinas
regiones=("Noroeste" "Noreste" "Centro" "Cuyo" "Pampeana" "Metropolitana" "Comahue" "Patagonia")
provincias=("Jujuy" "Formosa" "Santa Fe" "Mendoza" "Rosario" "Buenos Aires" "Santa Rosa" "Bariloche")

#Fultro para obtener la temperatura del txt
function filtro () {
    temperatura=$(echo "$pronostico" | grep -E "$estacion" | head -n1 | grep -oE "(;[1-9]+;)|(;[1-9]+\.[1-9]+;)" )
    echo "Pronostico en $estacion es $temperatura"
}

function menu_opciones () {
    variable=0
    echo "Seleccione una region/provincia:"
    for i in ${!regiones[@]}; do
        echo "$i) ${regiones[$i]}"
        variable=$(($variable+1))  
    done
    echo "$variable) Salir." 
}

#Obtener datos meteorologicos argentinos (se crea un archivo temporal)
fecha=$(date +"%Y%m%d")
url="https://ssl.smn.gob.ar/dpd/descarga_opendata.php?file=observaciones/tiepre$fecha.txt"
wget -q -o country/salida.txt "$url" 
pronostico=$(cat country/salida.txt)

menu_opciones
parada=$(($variable))
seleccion=100

#Ciclo de seleccion de regiones
until [ ${seleccion} == ${parada} ]; do
	read seleccion
	case $seleccion in
	${parada})
		continue
	;;
	*) if [[ ${seleccion} -gt -1 && ${seleccion} -lt $((${parada}-1)) ]]; then
	    estacion="${provincias[$seleccion]}"
	    filtro
	else
            echo "Opcion no valida"
	fi
	;;
esac
done

rm country/salida.txt

