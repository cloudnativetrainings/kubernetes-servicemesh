# Fault Injection

In this task you will bring in some chaos into your cluster.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Curl the api

```bash
curl -i $INGRESS_HOST/api
```

## Uncomment the `fault` section of the VirtualService and apply the changes

```bash
kubectl apply -f blue-virtualservice.yaml
```

## Curl the api again

Note that now we have some chaos in our cluster.

```bash
curl -i $INGRESS_HOST/api
```

## Clean up

```bash
kubectl delete -f .
```
