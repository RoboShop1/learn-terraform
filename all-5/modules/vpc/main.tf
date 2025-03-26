
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-vpc-igw"
  }
}

module "subnets" {
  source         = "./subnets"
  for_each       = var.subnets
  subnets        = each.value
  vpc_id         = aws_vpc.main.id
  env            = var.env
}

variable "vpc_cidr_block" {}
variable "env" {}
variable "subnets" {}