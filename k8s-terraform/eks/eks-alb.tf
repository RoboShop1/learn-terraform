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
# resource "aws_iam_role" "example" {
#   name               = "eks-pod-identity-example"
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }