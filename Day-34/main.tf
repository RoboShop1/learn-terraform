module "dev-vpc" {
  source                    = "./modules"
  env                       = "dev"
  vpc_cidr_block            = "10.1.0.0/16"

  public_subnet_cidr_blocks = ["10.1.1.0/16","10.1.2.0/16"]
  web_subnet_cidr_blocks    = ["10.1.3.0/16","10.1.4.0/16"]
  app_subnet_cidr_blocks    = ["10.1.5.0/16","10.1.6.0/16"]
  db_subnet_cidr_blocks     = ["10.1.7.0/16","10.1.8.0/16"]

  public_availability_zones = ["us-east-1a", "us-east-1b"]
  web_availability_zones    = ["us-east-1a", "us-east-1b"]
  app_availability_zones    = ["us-east-1a", "us-east-1b"]
  db_availability_zones     = ["us-east-1a", "us-east-1b"]
}

