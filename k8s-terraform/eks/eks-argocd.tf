
/* Add eks entry to access k8s-cluster */

data "aws_iam_role" "terraform-role" {
  depends_on = [aws_eks_addon.eks-pod-identity-agent]
  name = "terraform_role"
}
resource "aws_eks_access_entry" "k8s-access" {
  cluster_name      = aws_eks_cluster.dev-eks.name
  principal_arn     = data.aws_iam_role.terraform-role.arn
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "k8s-access-policy" {
  cluster_name  = aws_eks_cluster.dev-eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = data.aws_iam_role.terraform-role.arn

  access_scope {
    type = "cluster"
  }
}



# resource "null_resource" "install-argocd" {
#  depends_on = [null_resource.get-config,aws_eks_access_policy_association.k8s-access-policy,aws_eks_access_entry.k8s-access]
#
#  provisioner "local-exec" {
#    command = <<EOT
# kubectl create namespace argocd
# kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
#
# sleep 20
# kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
# echo -e "\e[32m $(kubectl get secret argocd-initial-admin-secret  -n argocd -o yaml | grep 'password' | echo $(awk -F: '{print $2}') | base64 -d) \e[0m"
# EOT
#  }
# }

# resource "null_resource" "argocd-secret" {
#   depends_on = [null_resource.install-argocd]
#
#   provisioner "local-exec" {
#     command = <<EOT
#
# echo -e "\e[32m $(kubectl get secret argocd-initial-admin-secret  -n argocd -o yaml | grep 'password' | echo $(awk -F: '{print $2}') | base64 -d) \e[0m"
#
# EOT
#   }
# }


# resource "null_resource" "delete-argocd-svc" {
#
#   provisioner "local-exec" {
#     when = destroy
#     on_failure = continue
#     command = <<EOT
# kubectl delete svc argocd-server -n argocd
# EOT
#   }
# }
#resource "kubernetes_annotations" "example" {
#  depends_on = [null_resource.install-argocd]
#  api_version = "v1"
#  kind        = "Service"
#  metadata {
#    name = "argocd-server"
#    namespace = "argocd"
#  }
#  annotations = {
#    "external-dns.alpha.kubernetes.io/hostname": "argocd.azcart.online"
#  }
#}
#
