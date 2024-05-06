#cat salida.json | grep -Eo '\"temperatura\":\"[1-9]+\.[1-9]' | head -n1
#
texto=$(cat $1)
primer=$(echo "$texto" | grep -Eo '\"temperatura\":\"[1-9]+\.[1-9]' | head -n1 )
echo "$primer"
