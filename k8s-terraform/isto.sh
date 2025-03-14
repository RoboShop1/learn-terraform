 helm repo add istio https://istio-release.storage.googleapis.com/charts
 helm repo update
 helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
 helm install istiod istio/istiod -n istio-system --wait
 helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait
 kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/kiali.yaml
 kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/prometheus.yaml