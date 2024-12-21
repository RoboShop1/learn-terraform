# resource "null_resource" "get-config" {
#   depends_on = [aws_eks_node_group.dev-eks-public-nodegroup, aws_eks_access_entry.k8s-access]
#
#   provisioner "local-exec" {
#     command = <<EOT
# aws eks update-kubeconfig --name ${aws_eks_cluster.dev-eks.name}
# sleep 10s
# EOT
#   }
# }