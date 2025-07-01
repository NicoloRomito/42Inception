all: up

up: 
	@docker compose -f ./srcs/docker-compose.yml up --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

delete:
	@docker compose -f ./srcs/docker-compose.yml down -v

# remove:
# 	@docker stop $(docker ps -qa);
# 	@docker rm $(docker ps -qa);
# 	@docker rmi -f $(docker images -qa);
# 	@docker volume rm $(docker volume ls -q);
# 	@docker network rm $(docker network ls -q) 2>/dev/null

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

start:
	@docker compose -f ./srcs/docker-compose.yml start

status:
	@docker ps