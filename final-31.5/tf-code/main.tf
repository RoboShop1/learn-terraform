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


