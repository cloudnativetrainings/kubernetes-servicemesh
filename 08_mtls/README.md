# Mutual TLS

In this lab you will learn how to enable mutual TLS.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Verify communication is unencrypted by default

```bash
# [bash-2] connect to to the pod green-v1
kubectl attach -it deployment green-v1

# [bash-1] follow the logs of the pod blue-v1
kubectl logs -f deployment/blue-v1

# [bash-2] make a http request to the blue-v1 service from within the green-v1 pod
request http://blue:8080/
```

> Note: in `bash-2` (pod `green-v1`) you should get an info that the response was not encrypted and no proxied certificate was sent back.

> Note: in `bash-1` (pod `blue-v1`) you should get an info that the request was sent via http no proxied certificate was sent.

## Engage encryption

```bash
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  namespace: training
  name: default
spec:
  mtls:
    mode: STRICT
EOF
```

```bash
kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot
```


### Verify via the application

kubectl -n istio-system logs -f istio-ingressgateway-9dfbbdd94-wzl98

kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80

# [bash-2] trigger a request from the blue pod to one of the green pods
request http://green:8080

request https://green:8080

kubectl logs -f green-v1-79dbb7db89-t5xzx -c istio-proxy  


kubectl exec -it green-v1-79dbb7db89-t5xzx -c istio-proxy  -- tcpdump -i any -w /tmp/traffic.pcap

kubectl exec -it <envoy-pod-name> -n <namespace> -- tcpdump -i any -w /tmp/traffic.pcap


kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot


curl -H "Host: blue.training.svc.cluster.local" $GATEWAY_IP/mtls
```

Note an output like this verifies tls communication

```log
mtls request - client cert header By=spiffe://cluster.local/ns/training/sa/default;Hash=7a27fff898812a54990ae99edd24346880a7c1614cf031077139f68ca571d0a9;Subject="";URI=spiffe://cluster.local/ns/istio-system/sa/istio-ingressgateway-service-account
```

#### Request the application from the `green` container and note the client cert header

```bash
kubectl exec -it <GREEN-POD> -c green -- curl blue:8080/mtls
```

Note an output like this verifies tls communication

```log
mtls request - client cert header By=spiffe://cluster.local/ns/training/sa/default;Hash=7a27fff898812a54990ae99edd24346880a7c1614cf031077139f68ca571d0a9;Subject="";URI=spiffe://cluster.local/ns/istio-system/sa/istio-ingressgateway-service-account
```

### Verify via Kiali

```bash
istioctl dashboard kiali
```

Use the feature `Web Preview` of Google Cloud Shell. You have to change the port.

#### Put some traffic onto our services

Do this in seperate cloud shells.

```bash
while true; do curl -H "Host: blue.training.svc.cluster.local" $GATEWAY_IP/mtls; sleep 5; done
```

```bash
while true; do kubectl exec -it <FRONTENT-POD> -c green -- curl blue:8080/mtls; sleep 5; done
```

#### Verify TLS with Kiali

Check the Graph and enable the Security Display Setting. There has to be a TLS symbol on the edges.

## Unencrypted communication

### Costumize the namespace `training`

Create the `disable-tls.yaml` file and create the PeerAuthentication.

```yaml
apiVersion: "security.istio.io/v1beta1"
kind: "PeerAuthentication"
metadata:
  namespace: training
  name: disable
spec:
  mtls:
    mode: DISABLE
```

```bash
kubectl create -f disable-tls.yaml
```

### Verify via the application again

Verify your Cloud Shell curling the blue application directly.

Note an output like this verifies tls communication

```log
mtls request - no client cert header
```

Verify your Cloud Shell curling the blue application from the green container.

Note an output like this verifies tls communication

```log
mtls request - no client cert header
```

### Verify via Kiali again

```bash
istioctl dashboard kiali
```

Use the feature `Web Preview` of Google Cloud Shell. You have to change the port.

#### Verify TLS with Kiali again

Check the Graph and enable the Security Display Setting. There has to be no TLS symbol on the edges.

## Clean up

Stop curl-while-loops in the Cloud Shells.

```bash
kubectl delete -f .
```
