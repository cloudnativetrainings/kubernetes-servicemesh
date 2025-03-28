.PHONY: verify
verify:
	docker --version
	kind --version
	kubectl version --client
	helm version
	istioctl version
	test -n "$(INGRESS_IP)"
	test -n "$(INGRESS_URL)"
	./pre-checks.sh
	echo "Training Environment successfully verified"
