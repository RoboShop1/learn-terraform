resource "aws_iam_openid_connect_provider" "default" {
  url = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer

  client_id_list  = ["sts.amazonaws.com"]

  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]

  tags = {
    Name = "eks-oidc"
  }
}


resource "aws_iam_role" "s33_role" {
  name = "s33_role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::339712959230:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/62E9F3B44BB1C4FC1B0769CD30BEC388"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "oidc.eks.us-east-1.amazonaws.com/id/62E9F3B44BB1C4FC1B0769CD30BEC388:aud": "sts.amazonaws.com",
            "oidc.eks.us-east-1.amazonaws.com/id/62E9F3B44BB1C4FC1B0769CD30BEC388:sub": "system:serviceaccount:default:dev-sa"
          }
        }
      }
    ]
  })

  tags = {
    tag-key = "s3-value"
  }
}


resource "aws_iam_role_policy_attachment" "s3-attach" {
  role       = aws_iam_role.s33_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


# resource "aws_iam_role_policy_attachment" "s31-attach" {
#   role       = aws_iam_role.s33_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }



# kubergrunt  eks oidc-thumbprint  --issuer-url aws_eks_cluster.cluster.identity.0.oidc.0.issuer