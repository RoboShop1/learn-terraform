resource "aws_iam_openid_connect_provider" "default" {
  url = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer

  client_id_list  = ["sts.amazonaws.com"]

  thumbprint_list = ["62E9F3B44BB1C4FC1B0769CD30BEC388"]

  tags = {
    Name = "eks-oidc"
  }
}