# Circuit Breaker

In this task you will configure a circuit breaker.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Request the application

```bash
curl -i $GATEWAY_IP
```

## Trigger the circuit breaker to get into open state

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] disable the root endpoint
disable /

# [bash-2] verify the setting
config
```

What do we expect?

- the first 3 responses with status code `503` are from the application itself with the following text `The root endpoint of the application is disabled`
- afterwards the proxy is catching the requests for one minute responding also with a status code `503` with the text `no healthy upstream`. Note that no request gets sent to the application for one minute.

```bash
curl -i $GATEWAY_IP
curl -i $GATEWAY_IP
curl -i $GATEWAY_IP
curl -i $GATEWAY_IP
```

### Close the Circuit again

> Note you have to wait for a minute before you can request again.

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] enable the root endpoint
enable /

# [bash-2] verify the setting
config

# request the application
curl -i $GATEWAY_IP
```

The application should be back to normal and receive requests. The application got 1 minute for healing itself.

## Clean up

```bash
# [bash-2] reset the application configuration
init

kubectl delete -f .
```
