# Routing via percent

In this training you will learn how to route some traffic towards different versions of an application.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Curl the application

Verify that ~ 90 % of the requests are from Version 2.0.0

```bash
while true; do curl $GATEWAY_IP; sleep 1; done;
```

## Adapt the LoadBalancer

Change the percentage in the VirtualService to eg 50 % per version in the file `green-virtualservice.yaml`

```bash
kubectl apply -f green-virtualservice.yaml
```

## Curl the application again

Verify the change you made

```bash
while true; do curl $GATEWAY_IP; sleep 1; done;
```

## Clean up

```bash
kubectl delete -f .
```
