resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-vpc"
  }
}

module "subnets" {
  for_each = var.subnets
  source = "./subnets"
  vpc_id = aws_vpc.main.id
  subnets = each.value
  env     = var.env
}


resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.gw]
  for_each   = lookup(var.subnets,"public",null)
  domain     = "vpc"
}


# resource "aws_nat_gateway" "main" {
#   allocation_id = lookup(aws_eip.eip, )
#   subnet_id     = aws_subnet.example.id
#
#   tags = {
#     Name = ""
#   }
#   depends_on = [aws_internet_gateway.gw]
# }

output "eip" {
  value = aws_eip.eip
}







variable "vpc_cidr" {}
variable "env" {}
variable "subnets" {}

#
# output "out_sub" {
#   value = module.subnets
# }


output "public_subnets_ids" {
  value = { for i,k in lookup(lookup(module.subnets,"public",null),"subnet_ids",null): i=>k.id}
}
# output "sample1" {
#   value = { for i,k in  module.subnets: i=> k.subnets_ids if i == "public"}
# }

# output "sample" {
#   value = flatten([ for i,k in  module.subnets:  values(k.subnets_ids)  ])
# }


# output "out_sub" {
#   value ={for i,k in module.subnets:  i => values(k.subnets).*.id  }
# }