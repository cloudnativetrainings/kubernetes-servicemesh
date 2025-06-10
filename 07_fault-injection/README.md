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

## Bring some chaos into your cluster

### Engage fault injection

Uncomment the `fault` section of the VirtualService and apply the changes

```bash
kubectl apply -f blue-virtualservice.yaml
```

### Verify

What do we expect?

- some requests are delayed for some seconds
- some requests fail with a 500 status code with the text `fault filter abort`
- some requests work fine

```bash
curl -i $GATEWAY_IP
```

## Clean up

```bash
kubectl delete -f .
```
