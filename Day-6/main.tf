module "vpc" {
  source         = "./vpc"
  for_each       = var.vpc
  name           = each.key
  cidr_block     = each.value["cidr_block"]
}

output "main" {
  value = module.vpc
}

module "subnets" {
  source = "./subnets"
  for_each = var.subnets

  name              = each.key
  vpc_id            = module.vpc["dev"].vpc_id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
}


variable "subnets" {
  default = {
    public = {
      cidr_block        = ["10.0.1.0/24","10.0.2.0/24"]
      availability_zone = ["us-east-1a","us-east-1b"]
    }
    web = {
      cidr_block        = ["10.0.3.0/24","10.0.4.0/24"]
      availability_zone = ["us-east-1a","us-east-1b"]
    }
  }
}