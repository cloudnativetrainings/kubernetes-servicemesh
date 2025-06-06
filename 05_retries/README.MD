# Retries

In this task you will costumize the retries.

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

Uncomment the timeout and in the file `blue-virtualservice.yaml`

```bash
# apply the changes
kubectl apply -f blue-virtualservice.yaml
```

## Verify your changes

```bash
# [bash-2] attach to the application again, if you are not attached anymore, for seeing the logs

# [bash-1] send a request the application
curl $GATEWAY_IP
```

> Note that in sum now 4 requests to root will happen, the original one and three retries. None of them will be successful.

## Clean up

```bash
# [bash-2] reset the application configuration
init

kubectl delete -f .
```
