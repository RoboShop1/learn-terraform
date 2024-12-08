data "aws_iam_policy_document" "example" {
  statement {
      Sid = "VisualEditor0",
      Effect =  "Allow",
      Action = "s3:*",
      Resource =  "*"
    }
}

resource "aws_iam_policy" "example" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.example.json
}