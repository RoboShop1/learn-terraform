resource "null_resource" "get-config" {
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup,aws_eks_addon.eks-pod-identity-agent]

  provisioner "local-exec" {
    command = <<EOT
aws eks update-kubeconfig --name ${aws_eks_cluster.dev-eks.name}
sleep 10s
EOT
  }
}

variable "istio-instal" {
  default = false
}
resource "null_resource" "istio-create" {
  count = var.istio-instal ? 1 : 0
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup,aws_eks_addon.eks-pod-identity-agent]
  provisioner "local-exec" {
    command =<<EOT

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm install istio-base istio/base -n istio-system --set defaultRevision=default --create-namespace
helm install istiod istio/istiod -n istio-system --wait
helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/kiali.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/prometheus.yaml

EOT
  }
}

resource "null_resource" "istio-delete" {
  count = var.istio-instal ? 1 : 0
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup,aws_eks_addon.eks-pod-identity-agent]

  provisioner "local-exec" {
    when = destroy
    command =<<EOT

helm del istio-base  -n istio-system
helm del istiod -n istio-system
helm del istio-ingress -n istio-system
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/kiali.yaml
kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.24/samples/addons/prometheus.yaml

EOT
  }
}