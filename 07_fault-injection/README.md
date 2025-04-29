# Fault Injection

In this task you will bring in some chaos into your cluster.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Request the app

```bash
curl -i $GATEWAY_IP
```

## Uncomment the `fault` section of the VirtualService and apply the changes

```bash
kubectl apply -f blue-virtualservice.yaml
```

## Request the app again

Note that now we have some chaos in our cluster.

```bash
curl -i $GATEWAY_IP
```

## Clean up

```bash
kubectl delete -f .
```
