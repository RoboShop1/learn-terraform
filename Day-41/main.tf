module "vpc" {
  source             = "./vpc"

  env                = "dev"
  vpc_cidr_block     = "10.0.0.0/16"
  public_cidr_blocks = ["10.0.1.0/24","10.0.2.0/24"]
  web_cidr_blocks    = ["10.0.3.0/24","10.0.4.0/24"]
  app_cidr_blocks    = ["10.0.5.0/24","10.0.6.0/24"]
  db_cidr_blocks     = ["10.0.7.0/24","10.0.8.0/24"]

}

