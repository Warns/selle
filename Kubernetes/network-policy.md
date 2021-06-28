### Creating a network policy to control ingress and egress access to a specific pod under a specific namespace and environment  

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          name: api-pod
      namespaceSelector: # If you add a - infront of this section it will make the policy a separate policy and ingress rule will no longer be podSelector AND namespaceSelector but instead it will OR.
        matchLabels:
          name: prod
    ports:
    - protocol: TCP
      port: 3306
```

![image](https://user-images.githubusercontent.com/4021052/116643792-7b059600-a97a-11eb-8de5-00ae7bf944ae.png)


![image](https://user-images.githubusercontent.com/4021052/116644964-6aa2ea80-a97d-11eb-8f5f-5fed01fbf2d1.png)
