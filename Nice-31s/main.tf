module "dev" {
  source = "./modules/ssm"
  inputs = var.dev-values
  env    = "dev"
  access = "chaitu"
}


module "prod" {
  source = "./modules/ssm"
  inputs = var.prod-values
  env    = "prod"
  access = "renuka"
}

variable "dev-values" {
  default = {
    chaitu1 = "chaitu1"
    chaitu2 = "chaitu2"
    chaitu3 = "chaitu3"
  }
}

variable "prod-values" {
  default = {
    r1 = "r1"
    r2 = "r2"
    r3 = "r3"
  }
}