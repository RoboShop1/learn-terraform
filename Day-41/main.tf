module "vpc" {
  source             = "./vpc"

  env                = "dev"
  vpc_cidr_block     = "10.0.0.0/16"
  subnets            = var.subnets

}

variable "subnets" {
  default = {
    public-subnets = {
      cidr_blocks = ["10.0.1.0/24","10.0.2.0/24"]
      nat_route   = false

    }
    web-subnets = {
      cidr_blocks = ["10.0.3.0/24","10.0.4.0/24"]
      nat_route   = true
    }
    app-subnets = {
      cidr_blocks = ["10.0.5.0/24","10.0.6.0/24"]
      nat_route   = true
    }
    db-subnets = {
      cidr_blocks = ["10.0.7.0/24","10.0.8.0/24"]
      nat_route   = true
    }
  }
}


output "final" {
  value = module.vpc
}