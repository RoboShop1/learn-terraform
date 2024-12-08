data "aws_iam_policy_document" "example" {
  statement {
      sid = "VisualEditor0"
      effect =  "Allow"
      action = ["s3:*"]
      resources =  ["*"]
    }
}

resource "aws_iam_policy" "example" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.example.json
}