module "vpc" {
  source = "./vpc"
  name   = "dev"
  cidr_block = "10.0.0.0/16"
  subnets   = var.subnets
  availability_zones = var.availability_zones
}




variable "availability_zones" {
  default = ["us-east-1a","us-east-1b"]
}
variable "subnets" {
  default = {
    public = {
      public = {
        cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
      }
    }
    private = {
      web = {
        cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
      }
      app = {
        cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
      }
      db = {
        cidr_block = ["10.0.1.0/24","10.0.2.0/24"]
      }
    }
  }
}