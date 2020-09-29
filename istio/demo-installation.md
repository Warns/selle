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

