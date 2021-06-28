# Docker Networking

```sh 
# There are 4 types of networks in Docker
# 1. bridge: the default netowrking in Docker 
# 2. host: only works on linux (Which is the way to go to connect containers to each other on Cloud solutions Azure, AWS, Google Cloud)
# 3. none: no netowrking at all
# 4. any other custom networking
```
https://docs.docker.com/network/host/

> Normally by default the network is bridge and bridge doesn't allow containers to be connected to each other, so you either need to use --link method or a custom alternative method.



