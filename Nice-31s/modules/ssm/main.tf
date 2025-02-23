resource "aws_ssm_parameter" "secret" {
  for_each    = var.inputs
  name        = each.key
  description = "The parameter description"
  type        = "String"
  value       = each.value

  tags = {
    environment = "dev"
    access      = "chaitu"
  }
}

variable "inputs" {}