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
#
# output "merge" {
#   value = merge(var.vpc["dev"]["subnets"]["web"],var.vpc["dev"]["subnets"]["app"],var.vpc["dev"]["subnets"]["db"])
# }

