data "http" "ebs-policy" {
  url = "https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json"

  request_headers = {
    Accept = "application/json"
  }
}



resource "aws_iam_role" "ebs-role" {
  name               = "eks-pod-identity-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "pods.eks.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name = "eks-pod-identity-role"
  }
}


resource "aws_iam_role_policy" "ebs_policy" {
  name = "test_policy"
  role = aws_iam_role.ebs-role.id
  policy = data.http.ebs-policy.body
}

