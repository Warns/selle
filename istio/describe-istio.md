## Everything about istio

### Base Features

- Load balancing 
How communications done between service A and service B or how communications are done coming from outside

- Fine-grain Control
Rules, retries, failovers, fault injections. Gives you the ability to how you specifically talk to service A and not service B in certain situations.

- Access control
Making sure that the policies you have for your cloud native application is correct and is enforceable.

- Visibility
Logging, graphing, metrics.

### Istio components

- Pilot
This drvies the actual istio service mesh. It has A/B testing, control canary deployments, timeouts, it is the intelligence of how everything works and it is the driver of istio.

- Citadel
The security aspect of the service mesh, it has CA (Certificate Authority) built inside of it. 

	- It allows service A and service B talk to each other securely if they need to.

	- You can upgrade unencrypted traffic in your service mesh through citadel to make it encrypted going back and forth.

	- When communicating with multiple clusters Citadel handles the connection to be encrypted and secure.

- Mixer
This is where all the Sidecars and istio things come together. And puts the telemetry together to allow Pilot show the graphs.

istio service mesh diag
![](https://istio.io/latest/docs/ops/deployment/architecture/arch.svg)

> By injecting a sidecar into the service as a proxy, istio handles the comm between services. Envoy (proxy) injects itself into every microservice.

### What does service mesh do?

- Plugs itself into the intra-service communication
- Intercepts east-west, north-south traffic
- Captures telemetry related to services and traffic
- Adds an implicit security layer
- Enables service discovery (If a service has multiple versions, all of them can be registered with one service endpoint and at runtime we can define how the traffic is going to be routed to one of the versions (Policy driven routing and traffic management))
- Implements policy-driven routing and traffic management
- Interfaces well with legacy and modern infrastructure







