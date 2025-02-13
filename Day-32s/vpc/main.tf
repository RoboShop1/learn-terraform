
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

  ingress {
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-igw"
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


resource "aws_eip" "eip" {
  for_each = local.public_subnets
  domain   = "vpc"

  tags = {
    Name = "${var.env}-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "nat" {
  for_each      =  local.public_subnets

  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = each.value

  tags = {
    Name = "${var.env}-nat-${each.key}"
  }
  depends_on = [aws_internet_gateway.gw]
}


resource "aws_route" "igw" {
  for_each                  = local.public_rt

  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}



resource "aws_route" "web-ngw" {
  for_each                  = local.web_rt
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = can(regex(1,each.key)) ? aws_nat_gateway.nat["public1"].id:  aws_nat_gateway.nat["public2"].id
}


resource "aws_route" "app-ngw" {
  for_each                  = local.app_rt
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = can(regex(1,each.key)) ? aws_nat_gateway.nat["public1"].id:  aws_nat_gateway.nat["public2"].id
}

resource "aws_route" "db-ngw" {
  for_each                  = local.db_rt
  route_table_id            = each.value
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = can(regex(1,each.key)) ? aws_nat_gateway.nat["public1"].id:  aws_nat_gateway.nat["public2"].id
}



locals {

  #Subnets

  public_subnets = lookup({for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "public" },"public",null)
  web_subnets    = lookup({for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "web" },"web",null)
  app_subnets    = lookup({for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "app" },"app",null)
  db_subnets     = lookup({for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "db" },"db",null)

  #RT
  public_rt = lookup({for i,j in module.subnets: i => {for m,n in j.rt: m => n.id } if i == "public" },"public",null)
  web_rt    = lookup({for i,j in module.subnets: i => {for m,n in j.rt: m => n.id } if i == "web" },"web",null)
  app_rt    = lookup({for i,j in module.subnets: i => {for m,n in j.rt: m => n.id } if i == "app" },"app",null)
  db_rt     = lookup({for i,j in module.subnets: i => {for m,n in j.rt: m => n.id } if i == "db" },"db",null)

}

output "vpc_id" {
  value = aws_vpc.main.id
}


output "public_subnets" {
  value = local.public_subnets
}

output "app_subnets" {
  value = local.app_subnets
}

output "web_subnets" {
  value = local.web_subnets
}

output "db_subnets" {
  value = local.db_subnets
}


