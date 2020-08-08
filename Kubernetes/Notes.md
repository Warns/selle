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

> All container inside a pod talk to each other with localhost

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
        # The following env definition is used to avoid that problem. 
        env:
          - name: CURRENCY_EXCHANGE_SERVICE_HOST
            value: http://currency-exchange # This will be removed when using configMaps.
        # When using configMaps instead of this method the following will be used instead of the value: http://currency-exchange above
            valueFrom: 
                configMapKeyRef:
                    key: CURRENCY_EXCHANGE_SERVICE_HOST
                    name: currency-conversion-config-map
```

> This is a more reliable approach.

## Kubernetes provides service discovery and loadbalancing for free and automatically for your microservices. All you need to do is the above env variable where you provide service name "value: http://currency-exchange"

## K8S Config maps are the recommended option to store environment configurations. Each environment (Dev, QA, Prod) should have a different configuration for config maps. In the above example 

# IMPORTANT! Since LoadBalancers are expensive you should have multiple LBs for every microservice. Its needed as highly available thats why expensive. 

Instead, you need a centralized feature to be responsible for the routing the request to the appropriate service that load balancer does.

K8s provides the following concept for that.

## K8s Ingress
Instead of creating the services as loadbalancers. We switch them over to nodePort and create Ingress to route the request to the appropriate microservices based on the URLs.