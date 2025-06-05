# Circuit Breaker

In this task you will configure a circuit breaker.

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
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] disable the root endpoint
disable /

# [bash-2] verify the setting
config
```

## Request the application twice

Note that

- the first response is a 503 from the blue application
- the second response is a 503 from the istio proxy (the circuit breaker is in open mode)

```bash
curl -i $GATEWAY_IP

disable readiness in deployment

maxEjectionPercent = 10%


kubectl exec -it blue-v1-5bf79cf86c-8vnf2 -c istio-proxy -- pilot-agent request GET stats | grep failure
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
