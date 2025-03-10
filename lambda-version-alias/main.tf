

data "aws_lambda_function" "existing" {
  function_name = "sample"
}

resource "aws_lambda_function_url" "test_live" {
  function_name      = data.aws_lambda_function.existing.function_name
  authorization_type = "AWS_IAM"
}

output "url" {
  value = aws_lambda_function_url.test_live.function_url
}