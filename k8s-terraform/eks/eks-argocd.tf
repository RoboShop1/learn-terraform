
resource "null_resource" "install-argocd" {
  depends_on = [null_resource.get-config,helm_release.external-dns]

  provisioner "local-exec" {
    command = <<EOT
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 20
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
EOT
  }
}

resource "kubernetes_annotations" "example" {
  depends_on = [null_resource.install-argocd]
  api_version = "v1"
  kind        = "Service"
  metadata {
    name = "argocd-server"
    namespace = "argocd"
  }
  annotations = {
    external-dns.alpha.kubernetes.io/hostname: "argocd.azcart.online"
  }
}

