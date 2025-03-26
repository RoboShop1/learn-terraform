
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

  allocation_id = aws_eip.eip[each.key]["id"]
  subnet_id     = each.value

  tags = {
    Name = "${var.env}-vpc-${each.value}-nat"
  }
}

// *** public-igw-routes-public-subnets *** //
resource "aws_route" "public-route" {
  for_each                  = lookup(lookup(module.subnets,"public",null),"rt_ids",null)
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}

// *** nat-gateway-routes-app-subnets *** //
resource "aws_route" "app-route" {
  for_each                  = lookup(lookup(module.subnets,"app",null),"rt_ids",null)
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = can(regex(each.key,1)) ? aws_nat_gateway.nat["public1"].id : aws_nat_gateway.nat["public2"].id
}


// *** nat-gateway-routes-db-subnets *** //
resource "aws_route" "db-route" {
  for_each                  = lookup(lookup(module.subnets,"db",null),"rt_ids",null)
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                =  can(regex(each.key,1)) ? aws_nat_gateway.nat["public1"].id : aws_nat_gateway.nat["public2"].id
}






variable "vpc_cidr_block" {}
variable "env" {}
variable "subnets" {}


output "f-subnet" {
  value = module.subnets
}

output "eip" {
  value = aws_eip.eip
}