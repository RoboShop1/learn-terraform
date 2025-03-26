
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

resource "aws_eip" "eip" {
  for_each = lookup(lookup(module.subnets,"public",null),"subnets_ids",null)
  domain   = "vpc"

  tags = {
    Name = "${var.env}-vpc-${each.value}-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each      = lookup(lookup(module.subnets,"public",null),"subnets_ids",null)
  allocation_id = lookup(lookup(aws_eip,each.key,null),id,null)
  subnet_id     = each.value

  tags = {
    Name = "${var.env}-vpc-${each.value}-nat"
  }

}

variable "vpc_cidr_block" {}
variable "env" {}
variable "subnets" {}


output "f-subnet" {
  value = module.subnets
}