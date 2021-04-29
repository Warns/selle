# Create Nginx Ingress Controller

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

## Create Roles and RoleBinding

![image](https://user-images.githubusercontent.com/4021052/116611004-88049400-a93e-11eb-90b7-a4973188f5fa.png)  

### Role
Use `--dry-run=client` first to create this file and edit the roles.   

`kubectl create role ingress-role --namespace=ingress-space --verb=get --resource=pods --resource=services --dry-run=client -o yaml > role.yml`  

Ultimately the role config should look like below:  

```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2021-04-29T16:24:18Z"
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:app.kubernetes.io/name: {}
          f:app.kubernetes.io/part-of: {}
      f:rules: {}
    manager: python-requests
    operation: Update
    time: "2021-04-29T16:24:18Z"
  name: ingress-role
  namespace: ingress-space
  resourceVersion: "2525"
  selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/ingress-space/roles/ingress-role
  uid: bf2f1681-3fca-414d-abf6-d62b024dbdce
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  - pods
  - secrets
  - namespaces
  verbs:
  - get
- apiGroups:
  - ""
  resourceNames:
  - ingress-controller-leader-nginx
  resources:
  - configmaps
  verbs:
  - get
  - update
- apiGroups:
  - ""
  resources:
  - configmaps
  verbs:
  - create
- apiGroups:
  - ""
  resources:
  - endpoints
  verbs:
  - get
```

### RoleBinding
Use `--dry-run=client` first to create this file and edit the roles.   

`kubectl create rolebinding ingress-role-binding --namespace=ingress-space --role=ingress-role --dry-run=client -o yaml > rolebinding.yml`  

Ultimately the RoleBinding should look like below:  

```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: "2021-04-29T16:24:19Z"
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:app.kubernetes.io/name: {}
          f:app.kubernetes.io/part-of: {}
      f:roleRef:
        f:apiGroup: {}
        f:kind: {}
        f:name: {}
      f:subjects: {}
    manager: python-requests
    operation: Update
    time: "2021-04-29T16:24:19Z"
  name: ingress-role-binding
  namespace: ingress-space
  resourceVersion: "2526"
  selfLink: /apis/rbac.authorization.k8s.io/v1/namespaces/ingress-space/rolebindings/ingress-role-binding
  uid: 157c573e-7760-4214-ab16-9e2e1a1046e5
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ingress-role
subjects:
- kind: ServiceAccount
  name: ingress-serviceaccount
```

## Create ClusterRole and ClusterRoleBinding

![image](https://user-images.githubusercontent.com/4021052/116611213-c601b800-a93e-11eb-8e70-245463062ae5.png)  

### ClusterRole
Use `--dry-run=client` first to create this file and edit the cluster roles.   

`kubectl create clusterrole ingress-clusterrole --namespace=ingress-space --verb=get --resource=services --dry-run=client -o yaml > clusterrole.yml`  

Ultimately the ClusterRole should look like below:  

```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  creationTimestamp: "2021-04-29T20:53:42Z"
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:app.kubernetes.io/name: {}
          f:app.kubernetes.io/part-of: {}
      f:rules: {}
    manager: python-requests
    operation: Update
    time: "2021-04-29T20:53:42Z"
  name: ingress-clusterrole
  resourceVersion: "7855"
  selfLink: /apis/rbac.authorization.k8s.io/v1/clusterroles/ingress-clusterrole
  uid: 937b75c6-7a12-4a29-80c2-e4cd9f828079
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  - endpoints
  - nodes
  - pods
  - secrets
  verbs:
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - get
- apiGroups:
  - ""
  resources:
  - services
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - extensions
  resources:
  - ingresses
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - patch
- apiGroups:
  - extensions
  resources:
  - ingresses/status
  verbs:
  - update
```  

### ClusterRoleBinding

Use `--dry-run=client` first to create this file and edit the cluster roles.   

`kubectl create clusterrolebinding ingress-clusterrole-binding --namespace=ingress-space --role=ingress-clusterrole --dry-run=client -o yaml > clusterrole-binding.yml`  

Ultimately the ClusterRoleBinding should look like below:  

```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  creationTimestamp: "2021-04-29T21:03:05Z"
  labels:
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:app.kubernetes.io/name: {}
          f:app.kubernetes.io/part-of: {}
      f:roleRef:
        f:apiGroup: {}
        f:kind: {}
        f:name: {}
      f:subjects: {}
    manager: python-requests
    operation: Update
    time: "2021-04-29T21:03:05Z"
  name: ingress-clusterrole-binding
  resourceVersion: "1364"
  selfLink: /apis/rbac.authorization.k8s.io/v1/clusterrolebindings/ingress-clusterrole-binding
  uid: dea15ae6-2d88-4fbf-b35f-2faedb945761
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: ingress-clusterrole
subjects:
- kind: ServiceAccount
  name: ingress-serviceaccount
  namespace: ingress-space
```  

## Deploy the Ingress Controller  

![image](https://user-images.githubusercontent.com/4021052/116622001-abced680-a94c-11eb-9d6c-3b14ff115a01.png)  
Use `--dry-run=client` first to create the deployment given the information in previous steps

`kubectl create deployment ingress-controller --image=quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0 --namespace=ingress-space --dry-run=client -o yaml > ingress-controller-deployment.yml`  

Ultimately the deployment should look like blow:

```sh
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ingress-controller
  namespace: ingress-space
spec:
  replicas: 1
  selector:
    matchLabels:
      name: nginx-ingress
  template:
    metadata:
      labels:
        name: nginx-ingress
    spec:
      serviceAccountName: ingress-serviceaccount
      containers:
        - name: nginx-ingress-controller
          image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0
          args:
            - /nginx-ingress-controller
            - --configmap=$(POD_NAMESPACE)/nginx-configuration
            - --default-backend-service=app-space/default-http-backend
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          ports:
            - name: http
              containerPort: 80
            - name: https
              containerPort: 443
```

## Create a Service  

![image](https://user-images.githubusercontent.com/4021052/116622121-d882ee00-a94c-11eb-8374-cd707278a4cd.png)  

Create a service to make Ingress available to external users

Use `--dry-run=client` first to create the service given the information in previous steps  

`kubectl expose deployment ingress-controller --namespace=ingress-space --type=NodePort --port=80 --name=ingress --dry-run -o yaml > ingress-service.yml`  

The Service should ultimately look like below:  

```sh
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: ingress
  namespace: ingress-space
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
    nodePort: 30080
  selector:
    name: nginx-ingress
  type: NodePort
```

# Create Ingress Resource
Create the ingress resource to make the applications available at /wear and /watch on the Ingress service. (Create the ingress resource in the app namespace)  

The Service should look like below:  

```sh
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          serviceName: wear-service
          servicePort: 8080
      - path: /watch
        backend:
          serviceName: video-service
          servicePort: 8080
```

