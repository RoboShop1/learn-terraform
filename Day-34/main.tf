module "dev-vpc" {
  source                    = "./modules"
  env                       = "dev"
  vpc_cidr_block            = "10.1.0.0/16"

  public_subnet_cidr_blocks = ["10.1.1.0/24","10.1.2.0/24"]
  web_subnet_cidr_blocks    = ["10.1.3.0/24","10.1.4.0/24"]
  app_subnet_cidr_blocks    = ["10.1.5.0/24","10.1.6.0/24"]
  db_subnet_cidr_blocks     = ["10.1.7.0/24","10.1.8.0/24"]

  public_availability_zones = ["us-east-1a", "us-east-1b"]
  web_availability_zones    = ["us-east-1a", "us-east-1b"]
  app_availability_zones    = ["us-east-1a", "us-east-1b"]
  db_availability_zones     = ["us-east-1a", "us-east-1b"]

  peer_cidr_block = "10.2.0.0/16"
  transit_gateway_id = "tgw-0962e1979a204fdf0"
}


module "prod-vpc" {
  source                    = "./modules"
  env                       = "prod"
  vpc_cidr_block            = "10.2.0.0/16"

  public_subnet_cidr_blocks = ["10.2.1.0/24","10.2.2.0/24"]
  web_subnet_cidr_blocks    = ["10.2.3.0/24","10.2.4.0/24"]
  app_subnet_cidr_blocks    = ["10.2.5.0/24","10.2.6.0/24"]
  db_subnet_cidr_blocks     = ["10.2.7.0/24","10.2.8.0/24"]

  public_availability_zones = ["us-east-1a", "us-east-1b"]
  web_availability_zones    = ["us-east-1a", "us-east-1b"]
  app_availability_zones    = ["us-east-1a", "us-east-1b"]
  db_availability_zones     = ["us-east-1a", "us-east-1b"]


  peer_cidr_block = "10.1.0.0/16"
  transit_gateway_id = "tgw-0962e1979a204fdf0"

}
