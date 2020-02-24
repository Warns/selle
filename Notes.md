# Notes

```sh 
# Check docker logs for the last X time in a specific container
docker service logs -f --since 60s container_name
```

```sh 
# Equivalent of .WAR file to .NET
https://stackoverflow.com/questions/11762163/net-equivalents-for-ant-and-war-files
```

```sh
# creating a container on docker on port 8080(external):8080(internal) 
docker run -d --name tomcat-container -p 8080:8080 tomcat:latest
```

```sh
# if tomcat container is 404 then do the following
# 1. Login to container's bash by
docker exec -it container-name /bin/bash
# 2. Copy contents inside webapp.dist into webapp folder
```
```sh
# Find any file
find / -name context.xml
```

```sh
# AWS System Manager 
# For accessing the server throuhg a web consol instead of open SSH port
```


