# Kubernetes Notes

```sh 
# Kubernetes calls servers as Nodes. While AWS calls them as EC2 and GCP calls them Compute Engine and Azure calls them Virtual Servers.

# Typically you have 1 master node, but when you need high availability you create multiple master nodes. 

# A cluster is a combination of nodes and master nodes. Nodes that do the work are called worker nodes (or just nodes) and manager nodes are called master nodes.

```

# Kubectl
```sh 
kubectl create deployment # creates deployment, replicaset and pod
kubectl expose deployment # creates a service
```
### Pod is the smallest deployable unit in K8s
The container lives inside the pod
![](https://snipboard.io/OrZvpf.jpg)

### All container inside a pod talk to each other with localhost

### Pods can have mutliple containers. Pods in a single node can relate to the same application or different applications.