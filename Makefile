up:
	sh ./Deploys/Compose/Scripts/index.sh
up-swarm:
	sh ./Deploys/Swarm/Scripts/index.sh
down:
	cd ./Deploys/Compose && docker-compose down
	rm -rf ./data
clean:
	docker volume rm $(docker volume ls -qf dangling=true)
	docker network rm $(docker network ls | grep "bridge" | awk '/ / { print $1 }')
	docker rm -f $(docker ps -a -q)
	docker rmi $(docker images --filter "dangling=true" -q --no-trunc)