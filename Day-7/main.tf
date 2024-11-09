module "vpc" {
  source = "./vpc"
  name   = "dev"
  cidr_block = "10.0.0.0/16"
  subnets   = var.subnets
  availability_zones = var.availability_zones
}



#module "ec2-public" {
#  source = "./ec2"
#  name   = public
#  associate_public_ip_address = 1
#  subnet_id =
#}
#
#
#module "ec2-private" {
#  source = "./ec2"
#  name   = private
#  associate_public_ip_address = 0
#  subnet_id =
#}


variable "availability_zones" {
  default = ["us-east-1a","us-east-1b"]
}
variable "subnets" {
  default = {
    public = {
      public = {
        cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
        igw        = true
      }
    }
    private = {
      web = {
        cidr_block = ["10.0.3.0/24","10.0.4.0/24"]
        nat        = true
      }
      app = {
        cidr_block = ["10.0.5.0/24","10.0.6.0/24"]
        nat        = true
      }
      db = {
        cidr_block = ["10.0.7.0/24","10.0.8.0/24"]
        nat        = true
      }
    }
  }
}


output "out" {
  value = module.vpc
}