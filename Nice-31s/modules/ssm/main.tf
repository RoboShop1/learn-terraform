resource "aws_ssm_parameter" "secret" {
  for_each    = var.inputs
  name        = each.key
  description = "The parameter description"
  type        = "String"
  value       = each.value

  tags = {
    environment = var.env
    access      = var.access
  }
}

variable "env" {}
variable "access" {}
variable "inputs" {}