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

## Set the delay of the api to 10 seconds

```bash
curl $GATEWAY_IP/set_delay/10
```

## Uncomment the `timeout` and the `retries` section of the VirtualService and apply the change

```bash
vi blue-virtualservice.yaml
kubectl apply -f blue-virtualservice.yaml
```

Open a second terminal and watch the logfiles of the blue container

```bash
# Second terminal
kubectl logs -f <BLUE-POD> blue
```

## Request the application again

Watch the logs in the second terminal

```bash
# First terminal
curl $GATEWAY_IP
```

## Clean up

```bash
curl $GATEWAY_IP/set_delay/0
kubectl delete -f .
```
