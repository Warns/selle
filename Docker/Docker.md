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

```sh 
# Specify howmuch memory and CPU the container will use (100% CPU is equivalent to 100000 so 50% is 50000)
docker run -d -p 5000:5000 -m 512m --cpu-quota=50000 [image]
```

```sh 
# Check system stats of a container such as used memory and CPU
docker stats [container ID]
```

```sh 
# Creating an image for a project (The . in the end is important it specifies to build the image in the current directory)
docker build -t in28min/hello-world-python:0.0.2.RELEASE .
```

```sh 
# login to docker using secure --password-stdin
docker login --username warns --password-stdin < d_pass.txt
# The d_pass.txt simply contains the password in clear text
```
