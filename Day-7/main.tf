module "vpc" {
  source = "./vpc"
  name   = "dev"
  cidr_block = "10.0.0.0"
}