resource "null_resource" "install-argocd" {
  depends_on = [null_resource.get-config]

  provisioner "local-exec" {
    command = <<EOT
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

sleep 20
EOT
  }
}

