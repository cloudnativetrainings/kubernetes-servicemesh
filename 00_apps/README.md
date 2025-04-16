# Apps

In this lab you will install the applications we will use during the other labs.

Switch to the apps folder

```bash
cd 00_apps
```

## Understand the Apps

Inspect the Kubernetes Manifests and get an understanding of the applications with which we will be working.

```bash

https://github.com/cloudnativetrainings/training-application/

helm template
create ns
```

## Deploy the Apps

```bash
# apply the manifests
kubectl apply -f .

# switch to the namespace called 'training'
kubens training
```
