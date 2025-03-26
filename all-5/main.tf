module "vpc" {
  for_each         = var.vpc
  source           =  "./modules/vpc"
  vpc_cidr_block   = each.value["vpc_cidr_block"]
  env              = var.env
  subnets          = each.value["subnets"]
}


output "main-vpc" {
  value = module.vpc
}