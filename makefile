lint:
	helm lint --values values/$(environment).yaml .
plan:
	kubectl create namespace $(release) --dry-run=client -o yaml | kubectl apply -f -
	helm template $(release) ingress-nginx-internal/$(repo) --version ${version} --namespace $(release) --values values/$(environment).yaml >$(release).yaml

helm_repo_add:
	helm repo add ingress-nginx-internal https://kubernetes.github.io/ingress-nginx
	helm repo update

install_helm:
	kubectl create namespace $(release) --dry-run=client -o yaml | kubectl apply -f - 
	helm repo update
	helm upgrade --install ingress-nginx-internal ingress-nginx-internal/$(repo) --namespace $(release) --values values/$(environment).yaml
