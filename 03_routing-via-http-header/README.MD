# Routing via HTTP header

In this training we will setup routing based on a HTTP header.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Make a request for user bob

Verify that the response comes from green in version v1

```bash
curl -H "user: bob" $GATEWAY_IP
```

## Make an anonymous request

Verify that the response comes from green in version v2

```bash
curl $GATEWAY_IP
```

## Clean up

```bash
kubectl delete -f .
```
