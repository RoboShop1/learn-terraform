module "vpc" {
  source = "./vpc"
  env    = "dev"
  vpc_cidr = "10.0.0.0/16"
}