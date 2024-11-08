
variable "vpc" {
  default = {
    dev = {
      cidr_block = "10.0.0.0"
    }
    prod = {
      cidr_block = "10.0.0.0"
    }
  }
}