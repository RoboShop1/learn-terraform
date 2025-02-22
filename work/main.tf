data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda.py"
  output_path = "lambda_function_payload.zip"
}

output "all" {
  value = data.archive_file.lambda.output_base64sha256
}