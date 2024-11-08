
variable "vpc" {
  default = {
    dev = {
      cidr_block = "10.0.0.0/16"
    }
    prod = {
      cidr_block = "10.0.0.0/16"
    }
  }
}