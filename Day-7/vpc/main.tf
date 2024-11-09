resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name}-vpc-igw"
  }
}




module "public_subnets" {
  source                = "./subnets"
  for_each              = var.subnets["public"]

  vpc_id                = aws_vpc.main.id
  name                  = each.key
  cidr_block            = each.value["cidr_block"]
  availability_zones    = var.availability_zones
}



output "in_vpc" {
  value = module.public_subnets["public"]["in_subnets"]
}

