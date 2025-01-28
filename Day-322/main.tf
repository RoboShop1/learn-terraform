module "vpc" {
  for_each       = var.vpc
  source         = "./vpc"
  env            = each.key
  vpc_cidr_block = each.value["vpc_cidr_block"]
  subnets        = each.value["subnets"]
}