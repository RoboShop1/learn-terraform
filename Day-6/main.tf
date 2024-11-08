module "vpc" {
  source         = "./vpc"
  for_each       = var.vpc
  name           = each.key
  cidr_block     = each.value["cidr_block"]
}