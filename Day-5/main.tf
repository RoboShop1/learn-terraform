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


output "count" {
  value = length(element(module.vpc.public_subnets,0))
}
#
#module "ec2-public" {
#  count     = length(element(module.vpc.public_subnets,0))
#  source    = "./ec2"
#  name      = module.vpc.public_subnets[count.index].tags["Name"]
#  subnet_id = module.vpc.public_subnets[count.index].id
#}

#module "ec2-web" {
#  count     = length(module.vpc.web_subnets)
#  source    = "./ec2"
#  name      = module.vpc.web_subnets[count.index].tags["Name"]
#  subnet_id = module.vpc.web_subnets[count.index].id
#}
#
#module "ec2-app" {
#  count     = length(module.vpc.app_subnets)
#  source    = "./ec2"
#  name      = module.vpc.app_subnets[count.index].tags["Name"]
#  subnet_id = module.vpc.app_subnets[count.index].id
#}
#
#
#
#module "ec2-db" {
#  count        = length(module.vpc.db_subnets)
#  source       = "./ec2"
#  name         = module.vpc.db_subnets[count.index].tags["Name"]
#  subnet_id    = module.vpc.db_subnets[count.index].id
#}