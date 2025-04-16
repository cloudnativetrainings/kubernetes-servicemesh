# Timeouts

In this task you will configure a timeout.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Curl the api

```bash
curl $GATEWAY_IP/api
```

## Set the delay of the api to 10 seconds

```bash
curl $GATEWAY_IP/set_delay/10
```

## Curl the api again

Note the latency of the response

```bash
curl $GATEWAY_IP/api
```

## Uncomment the timeout in the VirtualService and apply the change

```bash
vi blue-virtualservice.yaml
kubectl apply -f blue-virtualservice.yaml
```

## Curl the api again

Note that we get a timeout response

```bash
curl $GATEWAY_IP/api
```

## Clean up

```bash
curl $GATEWAY_IP/set_delay/0
kubectl delete -f .
```
