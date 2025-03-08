terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}
# data "archive_file" "lambda" {
#   type        = "zip"
#   source_file = "lambda.py"
#   output_path = "lambda_function_payload.zip"
# }
#
# output "all" {
#   value = data.archive_file.lambda.output_base64sha256
# }

resource "random_password" "example" {
  length           = 16
  special         = true
  upper           = true
  lower           = true
  numeric         = true
}

output "generated_password" {
  value = random_password.example.result
  sensitive = true
}

resource "local_file" "sample" {
  filename = "./one.txt"

  content = "${random_password.example.result}"
}