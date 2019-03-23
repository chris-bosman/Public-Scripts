function docker-cleanup {
	CONTAINERS=$(docker ps -a -q)
	IMAGES=$(docker images -q)
	docker rm $CONTAINERS
	docker rmi $IMAGES
}