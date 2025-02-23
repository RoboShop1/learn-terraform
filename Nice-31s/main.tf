module "dev" {
  source = "./modules/ssm"
  inputs = var.dev-values
}

variable "dev-values" {
  default = {
    chaitu1 = "chaitu1"
    chaitu2 = "chaitu2"
    chaitu3 = "chaitu3"
  }
}