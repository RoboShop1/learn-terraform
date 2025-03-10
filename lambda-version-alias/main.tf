

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


resource "aws_lambda_permission" "allow_user" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunctionUrl"
  function_name = data.aws_lambda_function.existing.function_name
  principal     = "arn:aws:iam::339712959230:user/key-user"
  function_url_auth_type = "AWS_IAM"
}