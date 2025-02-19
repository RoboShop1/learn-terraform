# resource "aws_iam_policy" "sample" {
#   name        = "${var.env}-node-externalDNS"
#   path        = "/"
#   description = "${var.env}-node-externalDNS"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "route53:ChangeResourceRecordSets"
#       ],
#       "Resource": [
#         "arn:aws:route53:::hostedzone/*"
#       ]
#     },
#     {
#       "Effect": "Allow",
#       "Action": [
#         "route53:ListHostedZones",
#         "route53:ListResourceRecordSets",
#         "route53:ListTagsForResource"
#       ],
#       "Resource": [
#         "*"
#       ]
#     }
#   ]
# }
# EOF
# }
#
# variable "env" {
#   default = "prod"
# }
#
#
#
# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"
#
#     principals {
#       type        = "Service"
#       identifiers = ["pods.eks.amazonaws.com"]
#     }
#
#     actions = [
#       "sts:AssumeRole",
#       "sts:TagSession"
#     ]
#   }
# }
#
#
# resource "aws_iam_role" "example" {
#   name               = "sample"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }
#
#
# resource "aws_iam_role_policy_attachment" "example_s3" {
#   policy_arn = aws_iam_policy.sample.arn
#   role       = aws_iam_role.example.name
# }
#
# resource "aws_eks_pod_identity_association" "example" {
#   cluster_name    = "dev-eks"
#   namespace       = "default"
#   service_account = "external-dns"
#   role_arn        = aws_iam_role.example.arn
# }
#
#
# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }
#
#
#
#  resource "helm_release" "external-dns" {
#  name       = "external-dns"
#  repository = "https://kubernetes-sigs.github.io/external-dns/"
#  chart      = "external-dns"
#  version    = "1.14.5"
#  namespace = "default"
#
#  set {
#    name  = "serviceAccount.name"
#    value = "external-dns1"
#  }
# }