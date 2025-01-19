module "vpc" {
  source     = "./vpc"
  for_each   = var.vpc

  env        = each.key
  vpc_cidr   = each.value["cidr"]
  subnets    = each.value["subnets"]
}



variable "vpc" {}

output "main" {
  value = module.vpc
}

output "merge" {
  value = merge(var.vpc["subnets"]["web"],var.vpc["subnets"]["app"],var.vpc["subnets"]["db"])
}