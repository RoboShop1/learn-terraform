module "vpc" {
  source = "./vpc"
  env    = "dev"
  vpc_cidr = "10.0.0.0/16"
  availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]
  public_subnets_cidr = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

output "all" {
  value = [ for value in module.vpc.rt: value.id if value.tags.Name == "public-rt1" ]
}

output "subnets" {
  value = module.vpc.subnets
}