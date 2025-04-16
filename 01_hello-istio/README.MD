# Expose an application via Istio

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

```bash
# TODO no logs
kubectl -n istio-system logs -l app=istio-ingressgateway
kubectl -n istio-system logs <ISTIO-INGRESS-GATEWAY-POD>
```

## Verify the curl request in the log files of the `istio-proxy` container

```bash
# TODO no logs
kubectl logs <BLUE-POD> istio-proxy
```

## Verify the curl request in the log files of the `blue` container

```bash
kubectl logs <BLUE-POD> blue
```

## Clean up

```bash
kubectl delete -f .
```
