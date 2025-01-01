# resource "aws_eks_addon" "ebs-csi-addon" {
#   depends_on = [
#     aws_iam_role.ebs-csi-role,
#     aws_iam_role_policy_attachment.ebs-policy-attach
#   ]
#   cluster_name                = aws_eks_cluster.dev-eks.name
#   addon_name                  = "aws-ebs-csi-driver"
#   addon_version               = "v1.37.0-eksbuild.1"
#   resolve_conflicts_on_create = "OVERWRITE"
#   resolve_conflicts_on_update = "OVERWRITE"
#   service_account_role_arn    = aws_iam_role.ebs-csi-role.arn
# }



data "aws_iam_policy_document" "eks-route-assume-role" {
 statement {
   effect = "Allow"

   principals {
     type        = "Service"
     identifiers = ["pods.eks.amazonaws.com"]
   }

   actions = [
     "sts:AssumeRole",
     "sts:TagSession"
   ]
 }
}

resource "aws_iam_role" "ebs-csi-role" {
 name               = "aws_elb_role"
 assume_role_policy = data.aws_iam_policy_document.eks-route-assume-role.json
}


# resource "aws_iam_role" "ebs-csi-role" {
#   name = "test_role"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       },
#     ]
#   })
# }

resource "aws_iam_role_policy_attachment" "ebs-policy-attach" {
  role       = aws_iam_role.ebs-csi-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_pod_identity_association" "eks-ebs-pod-association" {
 cluster_name    = aws_eks_cluster.dev-eks.name
 namespace       = "kube-system"
 service_account = "ebs-csi-controller-sa"
 role_arn        = aws_iam_role.ebs-csi-role.arn
}


