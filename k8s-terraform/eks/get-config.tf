resource "null_resource" "get-config" {
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup]

  provisioner "local-exec" {
    command = <<EOT
aws eks update-kubeconfig --name ${aws_eks_cluster.dev-eks.name}
sleep 10s
EOT
  }

}