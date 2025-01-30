 helm repo add istio https://istio-release.storage.googleapis.com/charts
 helm repo update


 helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace


helm install istiod istio/istiod -n istio-system --wait



kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/prometheus.yaml
