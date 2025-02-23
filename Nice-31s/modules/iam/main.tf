resource "aws_iam_user" "main" {
  name = var.name
  tags = var.tags
}


variable "name" {}
variable "tags" {}