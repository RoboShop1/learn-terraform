data "aws_iam_policy_document" "example" {
  statement {
      sid = "VisualEditor0"
      effect =  "Allow"
      actions = ["s3:*"]
      resources =  ["*"]
    }
}

resource "aws_iam_policy" "example" {
  name   = "example_policy"
  path   = "/"
  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ssm:DescribeParameters",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ssm:resourceTag/component": "mysql"
                }
            }
        }
    ]
}
EOT
}