resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

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


variable "vpc_cidr" {}
variable "env" {}
variable "subnets" {}


# output "out_sub" {
#   value = module.subnets
# }

output "sample" {
  value = values({ for i,k in  module.subnets: i => k.subnets })
}
# output "out_sub" {
#   value ={for i,k in module.subnets:  i => values(k.subnets).*.id  }
# }