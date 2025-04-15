.PHONY: verify
verify:
	docker --version
	kind --version
	kubectl version --client
	helm version
	istioctl version
	./pre-checks.sh
	istioctl analyze --all-namespaces
	kubectl -n istio-system wait --for=condition=Available --timeout=10s deployment/prometheus
	kubectl -n istio-system wait --for=condition=Available --timeout=10s deployment/grafana
	kubectl -n istio-system wait --for=condition=Available --timeout=10s deployment/kiali
	kubectl -n istio-system wait --for=condition=Available --timeout=10s deployment/jaeger
	kubectl -n istio-system wait --for=condition=Available --timeout=10s deployment/skywalking-ui
	echo "Training Environment successfully verified"
