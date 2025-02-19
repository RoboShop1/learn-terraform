data "aws_iam_policy_document" "assume_role" {
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

resource "aws_iam_role" "alb" {
  name               = "eks-pod-identity-alb"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.alb.id

  policy = file("${path.module}/elb.json")
}

resource "aws_eks_pod_identity_association" "eks-alb-pod-assocation" {
  cluster_name    = aws_eks_cluster.dev-eks.name
  namespace       = "default"
  service_account = "elb-sa"
  role_arn        = aws_iam_role.alb.arn
}