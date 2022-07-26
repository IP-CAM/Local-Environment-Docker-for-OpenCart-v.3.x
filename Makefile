service=app
container=opencart-app

up:
	docker compose up -d

up-app:
	docker compose up ${service} -d

up-build:
	docker compose up ${service} --build -d

down:
	docker compose down -v --remove-orphans

restart: down up

restart-app:
	docker compose restart ${service}

build:
	docker compose rm -vsf
	docker compose down -v --remove-orphans
	docker compose build
	docker compose up -d

build-nc:
	docker compose rm -vsf
	docker compose down -v --remove-orphans
	docker compose build --no-cache
	docker compose up -d

shell:
	docker exec -it ${container} bash

stats:
	docker stats --no-stream

log:
	docker logs ${container} -f