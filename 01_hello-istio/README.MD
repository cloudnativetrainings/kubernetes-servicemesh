# Expose an application via Istio

In this lab you will learn how to expose an application via istio and how to debug connectivity issues.

Switch to the lab folder

```bash
cd 01_hello-istio
```

## Inspect and create the resources

```bash
kubectl create -f .
```

## Verify everything is working via curl

```bash
# ensure the istio-ingressgateway is in place
kubectl -n istio-system get svc istio-ingressgateway

# get the external IP of the istio-ingressgateway
kubectl -n istio-system get svc istio-ingressgateway -o jsonpath={.status.loadBalancer.ingress[0].ip}

# store the IP into an environment variable (in a way it survives IDE reconnects ;) )
echo "export GATEWAY_IP=$(kubectl -n istio-system get svc istio-ingressgateway -o jsonpath={.status.loadBalancer.ingress[0].ip})" >> /root/.trainingrc
cat /root/.trainingrc
source /root/.trainingrc
echo $GATEWAY_IP
# => note if you experience an IDE reconnect you can simple do a `source /root/.trainingrc`

# verify you get valid HTML from the blue application
curl $GATEWAY_IP
```

## Verify everything is working via browser

```bash
# port forward the gateway
kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80
# => a popup should appear to access the application in the browser
```

## Verify the sync state of the proxies

```bash
istioctl proxy-status
```

## Verify the curl request in the log files of the `ingressgateway` pod

> Note you have to enable this verbose logging on installing istio via istioctl with the flag `meshConfig.accessLogFile=/dev/stdout`

```bash
kubectl -n istio-system logs -l app=istio-ingressgateway
```

Each request has to trigger a log line like this:

```log
[2025-04-24T12:28:31.453Z] "GET / HTTP/1.1" 200 - via_upstream - "-" 0 221 1 0 "10.244.1.226" "curl/7.81.0" "d55fd136-2d44-4679-9c8c-39119f531777" "172.18.0.5" "10.244.1.127:8080" outbound|8080||blue.training.svc.cluster.local 10.244.1.218:38346 10.244.1.218:8080 10.244.1.226:37217 - -
```

## Verify the curl request in the log files of the `istio-proxy` container

> Note you have to enable this verbose logging on installing istio via istioctl with the flag `meshConfig.accessLogFile=/dev/stdout`

```bash
kubectl logs -l app=blue -c istio-proxy
```

Each request has to trigger a log line like this:

```log
[2025-04-24T12:28:31.453Z] "GET / HTTP/1.1" 200 - via_upstream - "-" 0 221 0 0 "10.244.1.226" "curl/7.81.0" "d55fd136-2d44-4679-9c8c-39119f531777" "172.18.0.5" "10.244.1.127:8080" inbound|8080|| 127.0.0.6:33767 10.244.1.127:8080 10.244.1.226:0 outbound_.8080_._.blue.training.svc.cluster.local default
```

## Verify the curl request in the log files of the `blue` container

```bash
kubectl logs -l app=blue
```

Each request has to trigger a log line like this:

```log
INFO[1038] Request to root
```

## Clean up

```bash
kubectl delete -f .
```
