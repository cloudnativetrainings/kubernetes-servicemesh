# Circuit Breaker

In this task you will configure a circuit breaker.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Curl the api

```bash
curl -i $GATEWAY_IP/api
```

## Set the api unavailable

```bash
curl $GATEWAY_IP/set_available/false
```

## Curl the api twice

Note that

- the first response is a 503 from the blue application
- the second response is a 503 from the istio proxy (the circuit breaker is in open mode)

```bash
curl -i $GATEWAY_IP/api
```

## Take a look at the log files of the `blue` container

Note that there are more than one requests to the api.

## Wait a minute

After one minute the CircuitBreaker is in closed state again and curl the api. The first response will be a 503 from the blue application.

```bash
curl $GATEWAY_IP/set_available/true
curl -i $GATEWAY_IP/api
```

## Clean up

```bash
kubectl delete -f .
```
