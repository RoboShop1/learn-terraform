
resource "aws_iam_role" "lambda_role" {
  name = "tf_lambda_role1"
  assume_role_policy =<<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOT
}


resource "aws_iam_policy" "lambda_ec2_policy" {
  name        = "lambda_ec2_describe_policy"
  description = "Allow Lambda to describe EC2 instances"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "ec2:DescribeInstances"
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  policy_arn = aws_iam_policy.lambda_ec2_policy.arn
  role       = aws_iam_role.lambda_role.name
}

data "archive_file" "sample" {
  source_file = "name.py"
  output_path = "name.zip"
  type        = "zip"
}


resource "aws_lambda_function" "test_lambda" {
  filename      = "name.zip"
  function_name = "sample2"
  role          = aws_iam_role.lambda_role.arn
  handler       = "name.lambda_handler"

  source_code_hash = data.archive_file.sample.output_base64sha256

  runtime = "python3.11"

  timeout = 120

  environment {
    variables = {
      foo = "bar"
    }
  }
}