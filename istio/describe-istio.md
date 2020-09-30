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

It allows service A and service B talk to each other securely if they need to.

You can upgrade unencrypted traffic in your service mesh through citadel to make it encrypted going back and forth.

-   
