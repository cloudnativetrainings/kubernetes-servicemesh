# Apps

In this lab you will install the applications we will use during the other labs.

Switch to the lab folder

```bash
cd 00_apps
```

## Understand the Apps

Inspect the Kubernetes Manifests and get an understanding of the applications with which we will be working.

```bash
# take a look at the source of the training application https://github.com/cloudnativetrainings/training-application/

# take a look into the helmchart called `my-app`

# template the helm chart and inspect the created yaml manifests
helm template my-application > app.yaml

# take a look at the configuration possibilities of the helm chart
helm show values my-app

# inspect the given my-application configurations in the files `blue-v1.yaml`, `green-v1.yaml` and `green-v2.yaml`
```

## Deploy the Apps

```bash
# create the namespace and enable sidecar-injection on all pods deployed in this namespace
kubectl create namespace training
kubectl label namespace training istio-injection=enabled

# switch to the namespace called 'training'
kubens training

# install apps
helm upgrade --install --atomic --namespace training blue-v1 ./my-app -f blue-v1.yaml
helm upgrade --install --atomic --namespace training green-v1 ./my-app -f green-v1.yaml
helm upgrade --install --atomic --namespace training green-v2 ./my-app -f green-v2.yaml
```

## Verify Apps

```bash
# verify helm releases
# => 3 releases have to exist
helm ls

# verify pods
# => 3 pods should be running
# => note that each pod has now 2 containers due to istio proxy injection
kubectl get pods

# verify services
# => 2 services should be running
kubectl get svc

# verify endpoints
# => two endpoints should exist, one pointing to a 1 pod, the second pointing to 2 pods
kubectl get endpoints
```
