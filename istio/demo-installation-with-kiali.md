## This guide is created by reference from https://istio.io/latest/docs/setup/getting-started/

Running the following commands from inside a K8s cluster.

1. Download istio latest version
```sh
curl -L https://istio.io/downloadIstio | sh -
```

2. Navigate to istio dir
```sh
cd istio-1.7.2
```

3. Add istioctl client to your path
```sh
export PATH=$PWD/bin:$PATH
```

4. Install istio demo configuration profile (Use the equivalent profile for production, this is only for demo)
```sh
istioctl install --set profile=demo
```

5. Add a namespace label to instruct istio to automatically inject Envoy sidecar proxies when you deploy your application
```sh
kubectl label namespace default istio-injection=enabled
```

6. Deploy the Bookinfo sample app
```sh
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
```

7. Check services and pods (The application will start. As each pod becomes ready, the Istio sidecar will be deployed along with it.)
```sh
kubectl get services
kubectl get pods
```

8. Verify everything is working correctly up to this point. Run this command to see if the app is running inside the cluster and serving HTML pages by checking for the page title in the response:
```sh
kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -s productpage:9080/productpage | grep -o "<title>.*</title>"
```

9. Open app to outside traffic
```sh
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml
```

10. Ensure that there are no issues with the configuration
```sh
istioctl analyze
```

11. Execute the following command to determine if your Kubernetes cluster is running in an environment that supports external load balancers
```sh
kubectl get svc istio-ingressgateway -n istio-system
```

12. Follow these instructions if you have determined that your environment has an external load balancer.

Set the ingress IP and ports:
```sh
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')
```

13. Set GATEWAY_URL
```sh
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```

14. Verify external access
```sh
echo "http://$GATEWAY_URL/productpage"
```
---

## Kiali Installation, this was created by reference from https://www.magalix.com/blog/working-with-istio-track-your-services-with-kiali

Accessing The Kiali Service using one of the two methods below:

1. Using port forwarding
```sh
kubectl -n istio-system port-forward svc/kiali 20001:20001
```

2. Converting the service to LoadBalancer
```sh
kubectl patch service kiali --patch '{"spec":{"type":"LoadBalancer"}}' -n istio-system
```

Then get the IP address and port:
```sh
kubectl -n istio-system get service kiali -o jsonpath='{.status.loadBalancer.ingress[0].ip}
```
```sh
kubectl -n istio-system get service kiali -o jsonpath='{.spec.ports[?(@.name=="http-kiali")].port}'
```

This will produce the IP on the terminal. Using that IP as ip-address:20001/kiali you will be able to access kiali externally.

---

**Let’s verify that our Bookinfo application is receiving traffic. Execute the following command:**
```sh
curl -o /dev/null -s -w %{http_code} http://52.146.55.86/productpage
```






