resource "aws_vpc" "main" {
  cidr_block         = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id             = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

module "subnets" {
  depends_on           = [aws_vpc.main,aws_internet_gateway.igw]
  for_each             = var.subnets
  source               = "./subnets"

  env                  = var.env
  subnet_name          = each.key
  subnets_cidr_blocks  = each.value["cidr_blocks"]
  vpc_id               = aws_vpc.main.id
  nat_route            = lookup(each.value,"nat_route",null)

}



locals {
  public_subnets_ids = flatten([for i,k in module.subnets: k["subnets"][*]["id"] if i == "public-subnets" ])
  web-subnets_ids    = flatten([for i,k in module.subnets: k["subnets"][*]["id"] if i == "web-subnets" ])
  # nat_gateway_ids    =  aws_nat_gateway.nat-gw.*.id
}








# output "vpc_subnets" {
#   value = module.subnets
# }


# output "public-debug" {
#   value = flatten([for i,k in module.subnets: k["subnets"][*]["id"] if i == "app-subnets" ])
# }



output "public" {
  value = local.public_subnets_ids
}

output "web" {
  value = local.web-subnets_ids
}

output "vpc_namt" {
  value = module.subnets.nat
}

# output "sample" {
#   value = [for i,k in module.subnets: lookup(k,"subnets",null) if i == "web-subnets" ]
# }


# resource "aws_internet_gateway" "igw" {
#   vpc_id             = aws_vpc.main.id
#
#   tags = {
#     Name = "${var.env}-igw"
#   }
# }

# resource "aws_eip" "eip" {
#   count              = length(module.subnets.public_subnets)
#   domain             = "vpc"
# }


# resource "aws_nat_gateway" "nat-gw" {
#   count              = length(module.subnets.public_subnets)
#   allocation_id      = element(aws_eip.eip.*.id,count.index)
#
#   subnet_id          = local.public_subnets_ids[count.index]
#
#   tags = {
#     Name = "gw NAT"
#   }
#
#   depends_on = [aws_internet_gateway.igw]
# }
#
# locals {
#   public_subnets_ids  = flatten([for i,k in module.subnets: k.*.id if i == "public_subnets"])
# }
#
#
#
# output "local" {
#   value = local.public_subnets_ids
# }
#
# output "public_subnets_ids" {
#   value = [for i,k in module.subnets: k.*.id if i == "public_subnets"]
# }
#
# output "truee" {
#   value = [for i,k in module.subnets: k.*.id if strcontains(i, "app")  ]
# }



# output "vpc_subnets" {
#   value = module.subnets
# }