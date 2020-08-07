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

## Pods can have mutliple containers. Pods in a single node can be related to the same application or different applications.

## Pods provide a way to put your containers together and give them an IP address. And provides a categorization for all the containers inside it by associating them with labels.

# Namespace 
Provides isolation for parts of a cluster from other parts of a cluster (within the same cluster)

Such as separating resources of Development and QA environments that are running inside the same cluster. By creating separate namespaces for Dev and QA envs. And associate each of the resources with that specific namespace.

# Replicaset
Replicasets ensure a specific number of pods are running all the time. So there will be a DESIRED number of pods and CURRENT running number of pods. Whenever a pod gets killed or fails Replicaset will create a new pod to meet the DESIRED number of pods.

# Distributed Database (ETCD) in the Master Node
Typically its recommended to have 2-3 replicas of the distributed database in the master node because its where Kubernetes keeps all the resources and Desired state of a cluster.

# deployment.yaml file
spec:
sessionAffinity: none/true #1. this should be set to none if our application is something like a Rest API. 2. And set to true if you have a web application in that case you will want all requests from one user to go to the same pod, because the session is maintained in that specific pod. 

> Kind: Service # Does not map to a deployment but maps to a pod. When mapping selectors etc.

# Kubernetes Service Environment
Whenever a k8s service starts it provides all the environment variables of other running services. Thats why when two different deployments are launched and one of them relies to the other the two microservices automatically connect to each other using the environment variables provided by k8s.

> But there is a catch to this because if the service that provides the env variables wasn't running at the time of need k8s will fail to provide the env variables. To avoid that use the following to provide a URL.

```YAML
  spec:
      containers:
      - image: in28min/currency-conversion:0.0.1-RELEASE #CHANGE
        imagePullPolicy: IfNotPresent
        name: currency-conversion
        # The following env definition is used to avoid that problem. *This is a more reliable approach.*
        env:
          - name: CURRENCY_EXCHANGE_SERVICE_HOST
            value: http://currency-exchange
```
