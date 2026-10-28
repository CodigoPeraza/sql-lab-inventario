#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker no está instalado o no está en el PATH." >&2
    exit 1
fi

mkdir -p backups

timestamp="$(date +%Y%m%d_%H%M%S)"
database="${MARIADB_DATABASE:-inventario}"
output="backups/${database}_${timestamp}.sql.gz"

docker compose exec -T db sh -c \
    'exec mariadb-dump -u root -p"$MARIADB_ROOT_PASSWORD" --databases "$MARIADB_DATABASE"' \
    | gzip > "$output"

echo "Backup generado: $output"
