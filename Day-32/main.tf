module "vpc" {
  source     = "./vpc"
  for_each   = var.vpc
  env        = each.key
  vpc_cidr   = each.value["cidr"]
}



variable "vpc" {}

output "merge" {
  value =  [for i,k in lookup(var.vpc,"subnets",null): i]
}