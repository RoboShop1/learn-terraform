

resource "aws_lambda_function_url" "test_live" {
  function_name      = "sample"
  qualifier          = "my_alias"
  authorization_type = "AWS_IAM"
}