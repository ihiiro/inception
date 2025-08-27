.PHONY: all up down build clean

all: up

up:
	docker-compose -f ./docker-compose.yml --env-file .env up -d --build

down:
	docker-compose -f ./docker-compose.yml --env-file .env down

build:
	docker-compose -f ./docker-compose.yml --env-file .env build

clean:
	docker-compose -f ./docker-compose.yml --env-file .env down -v
	docker system prune -af --volumes

logs:
	docker-compose -f ./docker-compose.yml --env-file .env logs -f

status:
	docker-compose -f ./docker-compose.yml --env-file .env ps