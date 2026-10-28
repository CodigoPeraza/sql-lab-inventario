.PHONY: up down logs shell reset backup restore

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f db

shell:
	docker compose exec db sh -c 'exec mariadb -u root -p"$$MARIADB_ROOT_PASSWORD" "$$MARIADB_DATABASE"'

reset:
	docker compose down -v

backup:
	./scripts/backup.sh

restore:
	@if [ -z "$(FILE)" ]; then echo "Uso: make restore FILE=backups/archivo.sql.gz"; exit 1; fi
	./scripts/restore.sh "$(FILE)"
