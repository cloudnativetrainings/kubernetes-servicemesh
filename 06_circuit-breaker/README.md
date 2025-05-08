# Circuit Breaker

In this task you will configure a circuit breaker.

<!-- TODO adapt the training application => root endpoint unavailable -->

## Inspect and create the resources

```bash
kubectl create -f .
```

## Request the app

```bash
curl -i $GATEWAY_IP
```

## Set the api unavailable

```bash
#TODO curl !!!!  set_available/false
```

## Request the application twice

Note that

- the first response is a 503 from the blue application
- the second response is a 503 from the istio proxy (the circuit breaker is in open mode)

```bash
curl -i $GATEWAY_IP
```

## Take a look at the log files of the `blue` container

Note that there are more than one requests to the api.

## Wait a minute

After one minute the CircuitBreaker is in closed state again and Request the app. The first response will be a 503 from the blue application.

```bash
#TODO curl !!!!  set_available/true
curl -i $GATEWAY_IP
```

## Clean up

```bash
kubectl delete -f .
```
