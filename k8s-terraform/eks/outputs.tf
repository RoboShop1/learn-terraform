output "cluster_name" {
  value = aws_eks_cluster.dev-eks.name
}

output "id" {
  value = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer
}