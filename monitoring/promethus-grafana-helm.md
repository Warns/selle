Installing Prometheus and Grafana

# Add and update repos to fetch charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

## Create monitoring namespace
`kubectl create namespace monitoring`

## Install Prometheus service and define storage
```
helm install prometheus prometheus-community/prometheus \
--namespace monitoring \
--set alertmanager.persistentVolume.storageClass="default" \
--set server.persistentVolume.storageClass="default"
```

## Create grafana.yaml
```
mkdir ${HOME}/environment/grafana

cat << EoF > ${HOME}/environment/grafana/grafana.yaml
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.monitoring.svc.cluster.local
      access: proxy
      isDefault: true
EoF
```

## Install grafana and allocate storage and user pass
```
helm install grafana grafana/grafana \
    --namespace monitoring \
    --set persistence.storageClassName="default" \
    --set persistence.enabled=true \
    --set adminPassword='subje' \
    --values ${HOME}/Documents/monitoring/grafana.yaml \
    --set service.type=LoadBalancer
```

## Import a predefined template with ID: 6417
