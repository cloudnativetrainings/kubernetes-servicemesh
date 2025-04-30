# Timeouts

In this task you will configure a timeout.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Request the app

```bash
curl $GATEWAY_IP
```

## Set the delay of the api to 10 seconds

```bash
curl $GATEWAY_IP/set_delay/10
```

## Request the application again

Note the latency of the response

```bash
curl $GATEWAY_IP
```

## Uncomment the timeout in the VirtualService and apply the change

```bash
vi blue-virtualservice.yaml
kubectl apply -f blue-virtualservice.yaml
```

## Request the application again

Note that we get a timeout response

```bash
curl $GATEWAY_IP
```

## Clean up

```bash
curl $GATEWAY_IP/set_delay/0
kubectl delete -f .
```
