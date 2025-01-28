resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}


variable "vpc_cidr_block" {}
variable "env" {}
variable "subnets" {}


module "subnets" {
  for_each   = var.subnets

  source     ="./subnets"
  env        = var.env
  vpc_id     = aws_vpc.main.id
  subnets    =  each.key
}