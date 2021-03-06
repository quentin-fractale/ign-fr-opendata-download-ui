#!/bin/sh
# Première étape : scraping de la page de l'IGN

# Le petit manuel
if [ "$1" = "-h" ] ; then
    echo "Usage: ./$(basename $0) https://geoservices.ign.fr/documentation/diffusion/telechargement-donnees-libres.html liens_ign.txt"
    echo "Show this help: ./$(basename $0) -h"
    exit 0
fi

# Arguments
SOURCE_URL=$1
OUTPUT_FILE=$2

# si le dossier parent n'existe pas, on le crée    
[ -d "$OUTPUT_FILE" ] || mkdir -p "$(dirname "$OUTPUT_FILE")"
# on supprime d'abord les anciens fichiers
rm "$OUTPUT_FILE"

echo "Téléchargement de la page : $SOURCE_URL"

# télécharge la page HTML (stream), extrait les liens et le stockent dans un fichier texte
curl "$SOURCE_URL" | \
    grep -oE '\b(https?|ftp|file)://[-A-Za-z0-9+&@# /%?=~_|!:,.;]*[-A-Za-z0-9+&@# /%=~_|]' > "$OUTPUT_FILE"
