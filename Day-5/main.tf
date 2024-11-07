module "vpc" {
  source = "./vpc"
  env    = "dev"
  vpc_cidr = "10.0.0.0/16"
  availability_zone = ["us-east-1a","us-east-1b",]
  public_subnets_cidr = ["10.0.1.0/24","10.0.2.0/24"]
  web_subnets_cidr = ["10.0.3.0/24","10.0.4.0/24"]
  app_subnets_cidr = ["10.0.5.0/24","10.0.6.0/24"]
  db_subnets_cidr = ["10.0.7.0/24","10.0.8.0/24"]
}


output "web" {
  value = module.vpc.web_subnets
}

#module "ec2" {
#  count = length(module.vpc.app_subnets)
#  source = "./ec2"
#  name   =
#}

