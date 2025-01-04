terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
resource "aws_iam_user" "eks-user" {
  name = "eks-user"

  tags = {
    tag-key = "eks-user"
  }
}

resource "aws_iam_role" "eks-role-user-access" {
  name = "eks-role-user-access"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${aws_iam_user.eks-user.arn}"
        },
        "Action": "sts:AssumeRole",
        "Condition": {}
      }
    ]
  })

  tags = {
    tag-key = "eks-role-user-access"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = aws_iam_role.eks-role-user-access.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": "eks:*",
        "Resource": "*"
      }
    ]
  })
}


resource "null_resource" "update-kubeconfig" {
  provisioner "local-exec" {
    command = "aws-auth upsert --maproles --rolearn ${aws_iam_role.eks-role-user-access.arn}  --username eks-user --groups  system:masters"
  }
}
















