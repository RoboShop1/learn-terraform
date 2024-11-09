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

resource "aws_eip" "main" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.main.id
  subnet_id     = lookup(lookup(module.public_subnets,"public",null),"subnets_full",null)[0].id

  tags = {
    Name = "dev-vpc-ngw"
  }
}

resource "aws_security_group_rule" "main" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_vpc.main.default_security_group_id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "public_subnets" {
  source                = "./subnets"
  for_each              = var.subnets["public"]

  vpc_id                = aws_vpc.main.id
  name                  = each.key
  cidr_block            = each.value["cidr_block"]
  availability_zones    = var.availability_zones
  igw                   = lookup(each.value,"igw",false)  # This to be true so we need to igw_id
  igw_id                = aws_internet_gateway.gw.id      # we need to pass it.
  nat                   = lookup(each.value,"nat",false)
}


module "private_subnets" {
  source                = "./subnets"
  for_each              = var.subnets["private"]
  vpc_id                = aws_vpc.main.id
  name                  = each.key
  cidr_block            = each.value["cidr_block"]
  availability_zones    = var.availability_zones
  igw                   = lookup(each.value,"igw",false)  # This to false
  nat                   = lookup(each.value,"nat",false)  # This to true, so we need to pass ngw_id
  ngw_id                = aws_nat_gateway.example.id      # we need to pass it.
}



output "vpc_private" {
  value = module.private_subnets
}

output "vpc_public" {
  value = module.public_subnets
}



#output "all" {
#  value =  lookup(lookup(module.public_subnets,"public",null),"subnets_1",null)[0].id
#}