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

# Pods
There can be multiple pods in a single node and multipe containers in a single pod. See image below.

## Pod is the smallest deployable unit in K8s
The container lives inside the pod
![](https://snipboard.io/OrZvpf.jpg)

### All container inside a pod talk to each other with localhost

## Pods can have mutliple containers. Pods in a single node can relate to the same application or different applications.

## Pods provide a way to put your containers together and give them an IP address. And provides a categorization for all the containers inside it by associating them with labels.

# Namespace 
Provides isolation for parts of a cluster from other parts of a cluster (within the same cluster)

Such as separating resources of Development and QA environments that are running inside the same cluster. By creating separate namespaces for Dev and QA envs. And associate each of the resources with that specific namespace.

# Replicaset
Replicasets ensure a specific number of pods are running all the time. So there will be a DESIRED number of pods and CURRENT running number of pods. Whenever a pod gets killed or fails Replicaset will create a new pod to meet the DESIRED number of pods.
