resource "aws_vpc" "main" {
  cidr_block    = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

module "subnets" {
  depends_on         = [aws_vpc.main]

  source             = "./subnets"

  env                = var.env
  public_cidr_blocks = var.public_cidr_blocks
  web_cidr_blocks    = var.web_cidr_blocks
  app_cidr_blocks    = var.app_cidr_blocks
  db_cidr_blocks     = var.db_cidr_blocks
  vpc_id             = aws_vpc.main.id
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_eip" "eip" {
  count    = length(module.subnets.public_subnets)
  domain   = "vpc"
}


resource "aws_nat_gateway" "nat-gw" {
  count           = length(module.subnets.public_subnets)
  allocation_id   = element(aws_eip.eip.*.id,count.index)

  subnet_id       = local.public_subnets_ids[count.index]

  tags = {
    Name = "gw NAT"
  }

  depends_on = [aws_internet_gateway.igw]
}

locals {
  public_subnets_ids = flatten([for i,k in module.subnets: k.*.id if i == "public_subnets"])
}



output "local" {
  value = local.public_subnets_ids
}

output "public_subnets_ids" {
  value = [for i,k in module.subnets: k.*.id if i == "public_subnets"]
}

output "truee" {
  value = [for i,k in module.subnets: k.*.id if strcontains(i, "app")  ]
}



# output "vpc_subnets" {
#   value = module.subnets
# }