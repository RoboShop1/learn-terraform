resource "aws_eks_access_entry" "example" {
  cluster_name      = var.cluster_name
  principal_arn     = "arn:aws:iam::339712959230:role/eks_role_sts"
  type              = "STANDARD"
}

variable "cluster_name" {}

resource "aws_eks_access_policy_association" "example" {
  cluster_name  = var.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::339712959230:role/eks_role_sts"

  access_scope {
    type       = "cluster"
  }
}