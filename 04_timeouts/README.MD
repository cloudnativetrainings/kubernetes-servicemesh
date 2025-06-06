# Timeouts

In this task you will configure a timeout without making changes to the application itself.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Request the app

```bash
curl $GATEWAY_IP
```

## Mock the application has high latency

> Open an additional bash

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] configure the application to have a 10 seconds delay
delay / 10

# [bash-2] verify the latency setting
config
```

## Request the application again

> Note the latency of the response

```bash
curl $GATEWAY_IP
```

## Configure the VirtualService

Uncomment the timeout in the file `blue-virtualservice.yaml`

```bash
# apply the changes
kubectl apply -f blue-virtualservice.yaml
```

## Request the application again

```bash
curl $GATEWAY_IP
```

> Note that we get a timeout response after 5 seconds

## Clean up

```bash
# [bash-2] reset the application configuration
init

kubectl delete -f .
```
