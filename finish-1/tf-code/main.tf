provider "aws" {
  region = "us-east-1"
}



resource "aws_iam_role" "test_role" {
  name = "eks_role_admin"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::339712959230:root"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })

  tags = {
    tag-key = "eks_role_admin"
  }
}

resource "aws_iam_role_policy" "test_policy" {
  name = "eks_role_admin_policy"
  role = aws_iam_role.test_role.id

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





resource "aws_iam_group" "developers" {
  name = "developers"
}


resource "aws_iam_group_policy" "my_developer_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "sts:GetSessionToken",
          "sts:DecodeAuthorizationMessage",
          "sts:GetAccessKeyInfo",
          "sts:GetCallerIdentity",
          "sts:GetServiceBearerToken"
        ],
        "Resource": "*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "sts:*",
        "Resource": "arn:aws:iam::339712959230:role/arn:aws:iam::339712959230:role/eks_role_admin"
      }
    ]
  })
}

resource "aws_iam_group" "qa" {
  name = "qa"
}










