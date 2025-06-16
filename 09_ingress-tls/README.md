# Ingress TLS

In this task you will setup a certificate to be used for inbound traffic.

## Create the certs

```bash
# create root certificate
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=kubermatic training/CN=cloud-native.training' -keyout cloud-native.training.key -out cloud-native.training.crt

# create csr and key
openssl req -out green.cloud-native.training.csr -newkey rsa:2048 -nodes -keyout green.cloud-native.training.key -subj "/CN=green.cloud-native.training/O=kubermatic training"

# create certificate
openssl x509 -req -days 365 -CA cloud-native.training.crt -CAkey cloud-native.training.key -set_serial 0 -in green.cloud-native.training.csr -out green.cloud-native.training.crt
```

## Create a Secret in the `istio-system` namespace

```bash
kubectl create -n istio-system secret tls green.cloud-native.training --key=green.cloud-native.training.key --cert=green.cloud-native.training.crt
```

## Inspect and create the resources

```bash
kubectl create -f .
```

## Verify inbound TLS

### Verify via curl

```bash
while true; do curl -v --resolve "green.cloud-native.training:443:$GATEWAY_IP" --cacert cloud-native.training.crt "https://green.cloud-native.training:443/"; sleep 5; done
```

You should get a `Request Info` in the logs of the blue-v1 pod containing a header named `X-Forwarded-Client-Cert` similar to this one:

```log
X-Forwarded-Client-Cert: [By=spiffe://cluster.local/ns/training/sa/default;Hash=34b491b9c536a11f8b7596cc59903039fe58d23a98b6b83f29bfc72f26403df3;Subject="";URI=spiffe://cluster.local/ns/training/sa/default]
```

## Clean up

```bash
kubectl delete -f .
kubectl -n istio-system delete secret green.cloud-native.training
```
