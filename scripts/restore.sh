#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 backups/archivo.sql.gz" >&2
    exit 1
fi

cd "$(dirname "$0")/.."

backup_file="$1"

if [ ! -f "$backup_file" ]; then
    echo "No existe el archivo: $backup_file" >&2
    exit 1
fi

case "$backup_file" in
    *.gz) decompress=(gzip -dc) ;;
    *)    decompress=(cat) ;;
esac

"${decompress[@]}" "$backup_file" | docker compose exec -T db sh -c \
    'exec mariadb -u root -p"$MARIADB_ROOT_PASSWORD"'

echo "Restauración completada desde: $backup_file"
