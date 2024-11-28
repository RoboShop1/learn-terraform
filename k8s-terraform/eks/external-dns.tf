#data "aws_iam_policy_document" "eks-route-assume-role" {
#  statement {
#    effect = "Allow"
#
#    principals {
#      type        = "Service"
#      identifiers = ["pods.eks.amazonaws.com"]
#    }
#
#    actions = [
#      "sts:AssumeRole",
#      "sts:TagSession"
#    ]
#  }
#}
#
#resource "aws_iam_role" "eks-route-role" {
#  name               = "aws_elb_role"
#  assume_role_policy = data.aws_iam_policy_document.assume_role.json
#}
#
#resource "aws_iam_role_policy" "eks-route-policy" {
#  name = "test_policy"
#  role = aws_iam_role.eks-route-role.id
#
#  policy = jsonencode({
#    "Version": "2012-10-17",
#    "Statement": [
#      {
#        "Effect": "Allow",
#        "Action": [
#          "route53:ChangeResourceRecordSets"
#        ],
#        "Resource": [
#          "arn:aws:route53:::hostedzone/*"
#        ]
#      },
#      {
#        "Effect": "Allow",
#        "Action": [
#          "route53:ListHostedZones",
#          "route53:ListResourceRecordSets",
#          "route53:ListTagsForResource"
#        ],
#        "Resource": [
#          "*"
#        ]
#      }
#    ]
#  })
#}
#
#resource "aws_eks_pod_identity_association" "external-pod-identity" {
#  cluster_name    = aws_eks_cluster.dev-eks.name
#  namespace       = "default"
#  service_account = "external-sa"
#  role_arn        = aws_iam_role.eks-route-role.arn
#}
#
#resource "helm_release" "external-dns" {
#  depends_on = [aws_eks_pod_identity_association.external-pod-identity]
#  name       = "external-dns"
#  repository = "https://kubernetes-sigs.github.io/external-dns/"
#  chart      = "external-dns"
#  version    = "1.14.5"
#  namespace = "default"
#
#  set {
#    name  = "serviceAccount.name"
#    value = "external-sa"
#  }
#}