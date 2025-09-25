
all: start

start:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env up -d --build

stop:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env down

rebuild:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env build

wipe:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env down -v
	docker system prune -af --volumes

view:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env logs -f

status:
	docker-compose -f ./docker-compose.yml --env-file /home/debian/Desktop/secrets/.env ps
