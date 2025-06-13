# Mutual TLS

In this lab you will learn how to enable mutual TLS.

## Inspect and create the resources

```bash
kubectl create -f .
```

## Verify unencrypted traffic

> Note via the file `peerauthentication.yaml` we disabled encryption for the namespace `training`.

```bash
# [bash-2] connect to to the pod green-v1
kubectl attach -it deployment green-v1

# [bash-1] follow the logs of the pod blue-v1
kubectl logs -f deployment/blue-v1

# [bash-2] make a http request from within the green-v1 pod towards the blue-v1 service 
request http://blue:8080/
```

You should get a `Request Info` in the logs of the blue-v1 pod not containing a header named `X-Forwarded-Client-Cert`

## Encrypt traffic

```yaml
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  namespace: training
  name: default
spec:
  mtls:
    mode: STRICT   # <= change this from `DISABLE` to `STRICT`
```

Apply the changed PeerAuthentication

```bash
kubectl apply -f peerauthentication.yaml
```

## Verify encrypted traffic

> Note via the file `peerauthentication.yaml` we disabled encryption for the namespace `training`.

```bash
# [bash-2] make a http request from within the green-v1 pod towards the blue-v1 service 
request http://blue:8080/
```

You should get a `Request Info` in the logs of the blue-v1 pod containing a header named `X-Forwarded-Client-Cert` similar to this one:

```log
X-Forwarded-Client-Cert: [By=spiffe://cluster.local/ns/training/sa/default;Hash=34b491b9c536a11f8b7596cc59903039fe58d23a98b6b83f29bfc72f26403df3;Subject="";URI=spiffe://cluster.local/ns/training/sa/default]
```

## Clean up

```bash
kubectl delete -f .
```
