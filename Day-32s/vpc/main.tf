resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

variable "env" {}
variable "vpc_cidr_block" {}
variable "subnets" {}

module "subnets" {

  depends_on = [aws_vpc.main]

  for_each   = var.subnets
  source     = "./subnets"
  subnets    = each.value
  vpc_id     = aws_vpc.main.id
  env        =  var.env
}

output "module_subnet" {
  value = {for i,j in module.subnets: i => k }
}