## Everything about istio

### Base Features

- Load balancing 
How communications done between service A and service B or how communications are done coming from outside

- Fine-grain Control
Rules, retries, failovers, fault injections. Gives you the ability to how you specifically talk to service A and not service B in certain situations. Fine-grain control over what traffic flows where.

- Access control
Making sure that the policies you have for your cloud native application is correct and is enforceable.

- Visibility
Logging, graphing, metrics.

- Resiliency between apps (retries, circuit breakers, outlier detection, etc.).


### Istio components

**Envoy**
Envoy is a sidecar proxy that will be locally available where the service is (in the pod on Kubernetes) and it intercepts the requests made by the service using iptables. When Envoy receives the request on the other service its gonna request a permission from Mixer to let it through or deny it.

**Pilot**
This drvies the actual istio service mesh. It has A/B testing, control canary deployments, timeouts, it is the intelligence of how everything works and it is the driver of istio.

**Citadel**
The security aspect of the service mesh, it has CA (Certificate Authority) built inside of it. When we want for example service A to talk to service B but not talk to service C this is where Citadel comes in. Citadel is responsible of issuing identities (certs) to all the workloads in the system that we can use to authenticate and encrypt the channel we establish when communicating. 

	- It allows service A and service B talk to each other securely if they need to.

	- You can upgrade unencrypted traffic in your service mesh through citadel to make it encrypted going back and forth.

	- When communicating with multiple clusters Citadel handles the connection to be encrypted and secure.

**Mixer**
This is where all the Sidecars and istio things come together. And puts the telemetry together to allow Pilot show the graphs. When a request comes from the service to a proxy, Envoy will hold up the request until Mixer gives the yes or no depending on the policy it has.

**Galley**
After having the Envoy (a sidecar proxy) proxies on the services Galley is deployed to do the configuration. Its the first element of the control plane.




istio service mesh diag
![](https://istio.io/latest/docs/ops/deployment/architecture/arch.svg)

istio architecture
![](https://istio.io/v1.1/docs/concepts/what-is-istio/arch.svg)

> By injecting a sidecar into the service as a proxy, istio handles the comm between services. Envoy (proxy) injects itself into every microservice.

### What does service mesh do?

- Plugs itself into the intra-service communication
- Intercepts east-west traffic
- Captures telemetry related to services and traffic
- Adds an implicit security layer
- Enables service discovery (If a service has multiple versions, all of them can be registered with one service endpoint and at runtime we can define how the traffic is going to be routed to one of the versions (Policy driven routing and traffic management))
- Implements policy-driven routing and traffic management
- Interfaces well with legacy and modern infrastructure


### istio routing example
```sh
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
	name: backend-to-whichever-cluster

```

## Keynotes
- istio has a name-centric config model (routes based on names). Use global naming scheme across your clusters.
- istio doesn't do DNS natively, but has plugins that do (via CoreDNS) using this DNS plugin we create global names for our services. This is necessary to route accross multiple clusters.
- using DNS+Istio config manipulating these names, we can affect traffic flow without changing applications, including bridging L3 networks
- you can route external services via an egress proxy to make network/firewall rules easy. (Not required but good to have to make firewall rules simpler.)
