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

Ultimately the role config should look like below:  

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
