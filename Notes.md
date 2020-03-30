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

# Scan the disk for all files and folders 
apt/yum install ncdu
ncdu /
```

```sh
# AWS System Manager 
# For accessing the server throuhg a web consol instead of open SSH port

Services > AWS System Manager > Session Manager

https://www.youtube.com/watch?v=WmdL8aOVooM

```

```sh
# Coloring the bash
vim ~/.bashrc
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
source ~/.bashrc
```

```sh
# Checking disk size
df -h
du -ahx / | sort -rh | head -n 20

# Install a scanner tool to show sizes
apt/yum install ncdu

# Run following command
sudo ncdu /
```

```sh
# Delete all files in a directory (for large number of files millions)
find . -name "mvssession*" -print0 | xargs -0 rm
```


```sh
# Finding erros in a log
find . -name "mvssession*" -print0 | xargs -0 rm
```
grep mysql /var/log/syslog | grep ERROR
