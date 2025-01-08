# resource "aws_eks_identity_provider_config" "oidc-auth" {
#
#
#   cluster_name = aws_eks_cluster.dev-eks.name
#
#   oidc {
#     client_id                     = element(tolist(split("/", tostring("${aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer}"))), 4)
#     identity_provider_config_name = "oidc-auth"
#     issuer_url                    = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer
#   }
# }

# https://oidc.eks.us-east-1.amazonaws.com/id/DB98342508D9536ED0CFC23EEF27206D/.well-known/openid-configuration

# same has like this

# resource "aws_eks_identity_provider_config" "example" {
#   cluster_name = aws_eks_cluster.dev-eks.name
#
#   oidc {
#     client_id                     = "DB98342508D9536ED0CFC23EEF27206D"
#     identity_provider_config_name = "iam-oidc"
#     issuer_url                    = "https://oidc.eks.us-east-1.amazonaws.com/id/DB98342508D9536ED0CFC23EEF27206D"
#   }
# }

resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = aws_eks_cluster.dev-eks.identity[0].oidc[0].issuer

  tags = {
      Name = "dev-eks-irsa"
  }
}

locals {
  oidc_provider_name_arn = aws_iam_openid_connect_provider.oidc_provider.arn
  oidc_provider_name_extract_arn = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.oidc_provider.arn}"), 1)
}

resource "aws_iam_role" "eks-cluster-autoscale" {
  name = "eks-cluster-autoscale"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : local.oidc_provider_name_arn
        },
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_provider_name_extract_arn}:aud" : "sts.amazonaws.com",
            "${local.oidc_provider_name_extract_arn}:sub" : "system:serviceaccount:default:dev-sa"
          }
        }
      }
    ]
  })

  tags = {
    Name = "eks-cluster-autoscale"
  }
}

resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.eks-cluster-autoscale.name
}

resource "aws_iam_role" "eks-cluster-route53" {
  name = "eks-cluster-route53"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : local.oidc_provider_name_arn
        },
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_provider_name_extract_arn}:aud" : "sts.amazonaws.com",
            "${local.oidc_provider_name_extract_arn}:sub" : "system:serviceaccount:default:dev-sa"
          }
        }
      }
    ]
  })

  tags = {
    Name = "eks-cluster-route53"
  }
}


resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess"
  role       = aws_iam_role.eks-cluster-route53.name
}




resource "aws_eks_addon" "eks-pod-identity-agent" {
  depends_on = [aws_eks_node_group.dev-eks-public-nodegroup]

  cluster_name                = aws_eks_cluster.dev-eks.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.36.0-eksbuild.1"
  resolve_conflicts_on_update = "OVERWRITE"
  resolve_conflicts_on_create = "OVERWRITE"
}







resource "aws_iam_role" "ebs" {
  name = "eks-cluster-ebs"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Principal" : {
          "Federated" : local.oidc_provider_name_arn
        },
        "Condition" : {
          "StringEquals" : {
            "${local.oidc_provider_name_extract_arn}:aud" : "sts.amazonaws.com",
            "${local.oidc_provider_name_extract_arn}:sub" : "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  })

  tags = {
    Name = "eks-cluster-ebs"
  }
}


resource "aws_iam_role_policy_attachment" "irsa_iam_ebs" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.ebs.name
}



















