module "vpc" {
  source     = "./vpc"
  for_each   = var.vpc
  env        = each.key
  vpc_cidr   = each.value["cidr"]
}



variable "vpc" {}

output "merge" {
  value =  keys({ for i,k in var.vpc["dev"]["subnets"]: i=>k })
}