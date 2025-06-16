# Egress Traffic

## Inspect and create the resources

```bash
kubectl create -f .
```

## Allow all outbound traffic

> Note this is the default setting in Istio.

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] do the request
request https://www.kubermatic.com/
```

> Note that you get a vaild response. You can reach servers outside your cluster.

## Disallow all outbound traffic

Run istioctl with the following flag.

```bash
istioctl install \
  --set profile=demo \
  --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY
```

You can verify your setting via the following. Note that the field `outboundTrafficPolicy.mode` has to be `REGISTRY_ONLY`

```bash
kubectl -n istio-system  get cm istio -o jsonpath="{.data.mesh}"
```

### Verify

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] do the request
request https://www.kubermatic.com/
```

> Note, now you should get an error message.

## Allow specific hosts being accessed

### Create the ServiceEntry

Create a file named `serviceentry.yaml`

```yaml
apiVersion: networking.istio.io/v1
kind: ServiceEntry
metadata:
  name: kubermatic
spec:
  hosts:
    - www.kubermatic.com
  ports:
    - number: 443
      name: https
      protocol: HTTPS
  resolution: DNS
  location: MESH_EXTERNAL
```

Apply it to the cluster

```bash
kubectl create -f serviceentry.yaml
```

### Verify again

```bash
# [bash-2] connecto to the application
kubectl attach -it deployment blue-v1

# [bash-2] do the request
request https://www.kubermatic.com/
```

> Note, now the request should work again.

## Clean up

```bash
kubectl delete -f .
```
