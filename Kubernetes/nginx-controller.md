## Create a namespace
Create a name space called `ingress-space` to hold everything related to the ingress controller  

`kubcetl create namespace ingress-space`  

![image](https://user-images.githubusercontent.com/4021052/116583837-6d6ef280-a91f-11eb-95f9-6a306527fc4e.png)

## Create a config map
The NGINX Ingress Controller requires a ConfigMap object. Create a ConfigMap object in the ingress-space.  

`kubectl create configmap nginx-configuration --namespace=ingress-space`  

![image](https://user-images.githubusercontent.com/4021052/116584331-e706e080-a91f-11eb-9c21-8a27ba2edff0.png)

## Create a ServiceAccount
The NGINX Ingress Controller requires a ServiceAccount. Create a ServiceAccount in the ingress-space.  

`kubectl create serviceaccount ingress-serviceaccount --namespace=ingress-space`  

![image](https://user-images.githubusercontent.com/4021052/116584780-60063800-a920-11eb-8154-05e127c88d00.png)

