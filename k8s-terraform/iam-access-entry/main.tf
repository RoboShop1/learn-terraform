resource "aws_iam_role" "test_role" {
  name = "eks-demo-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "eks-demo-role"
  }
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "eks-demo-role-test-profile"
  role = aws_iam_role.test_role.name
}

resource "aws_iam_role_policy" "test_policy" {
  name = "eks-demo-policy"
  role = aws_iam_role.test_role.id

  policy = file("${path.module}/file.json")
}

resource "aws_instance" "web" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.test_profile.name
  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
    }
  }
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_eks_access_entry" "example" {
  cluster_name      = var.cluster_name
  principal_arn     = aws_iam_role.test_role.arn
  type              = "STANDARD"
  kubernetes_groups = ["dev:read"]
}

variable "cluster_name" {}

resource "aws_eks_access_policy_association" "example" {
  cluster_name  = var.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy"
  principal_arn = aws_iam_role.test_role.arn

  access_scope {
    type       = "namespace"
    namespaces = ["default"]
  }
}