
resource "aws_iam_role" "lambda_role" {
  name = "tf_lambda_role"
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

  runtime = "python3.11"

  environment {
    variables = {
      foo = "bar"
    }
  }
}