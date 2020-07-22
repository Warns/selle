# Docker Notes

```sh 
# Check docker logs for the last X time in a specific container
docker service logs -f --since 60s container_name
```

```sh
# creating a container on docker on port 8080(external, host port ):8080(internal, container port) 
docker run -d --name tomcat-container -p 8080:8080 tomcat:latest
```

```sh
# if tomcat container is 404 then do the following
# 1. Login to container's bash by
docker exec -it container-name /bin/bash
# 2. Copy contents inside webapp.dist into webapp folder
```

```sh 
# Check a container for all possible info to debug
docker container inspect [docker ID]
```
