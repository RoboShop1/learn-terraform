module "ec2" {
  source = "./ec2"

  for_each = var.instances
  name     = each.key
  ami      = each.value["ami"]
  instance_type = each.value["ami"]
}

variable "instances" {
  default = {
    web = {
      ami = "ami-0984f4b9e98be44bf"
      instance_type = "t2.micro"
    }
    app = {
      ami = "ami-0984f4b9e98be44bf"
      instance_type = "t2.micro"
    }
    db = {
      ami = "ami-0984f4b9e98be44bf"
      instance_type = "t2.micro"
    }
  }
}
















#module "vpc" {
#  source         = "./vpc"
#  for_each       = var.vpc
#  name           = each.key
#  cidr_block     = each.value["cidr_block"]
#}
#
#output "main" {
#  value = module.vpc
#}
#
#module "subnets" {
#  source = "./subnets"
#  for_each = var.subnets
#
#  name              = each.key
#  vpc_id            = module.vpc["dev"].vpc_id
#  cidr_block        = each.value["cidr_block"]
#  availability_zone = each.value["availability_zone"]
#}
#
#
#output "main1" {
#  value = module.subnets
#}
#
#
#variable "subnets" {
#  default = {
#    public = {
#      cidr_block        = ["10.0.1.0/24","10.0.2.0/24"]
#      availability_zone = ["us-east-1a","us-east-1b"]
#    }
#    web = {
#      cidr_block        = ["10.0.3.0/24","10.0.4.0/24"]
#      availability_zone = ["us-east-1a","us-east-1b"]
#    }
#  }
#}