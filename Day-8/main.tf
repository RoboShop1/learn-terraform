module "dev-vpc" {
  source = "./vpc"
  env    = "dev"
  vpc_cidr_block = "10.1.0.0/16"
  public_subnets_cidr_blocks = ["10.1.1.0/24","10.1.2.0/24"]
  private_subnets_cidr_blocks = ["10.1.3.0/24","10.1.4.0/24"]
  availability_zones = ["us-east-1a","us-east-1b"]
}

module "qa-vpc" {
  source = "./vpc"
  env    = "qa"
  vpc_cidr_block = "10.2.0.0/16"
  public_subnets_cidr_blocks = ["10.2.1.0/24","10.2.2.0/24"]
  private_subnets_cidr_blocks = ["10.2.3.0/24","10.2.4.0/24"]
  availability_zones = ["us-east-1a","us-east-1b"]
}



