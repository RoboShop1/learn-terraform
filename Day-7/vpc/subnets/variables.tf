variable "vpc_id" {}
variable "cidr_block" {}
variable "availability_zones" {}
variable "name" {}

variable "igw" {}

variable "igw_id" {
  default = null
}

variable "nat" {}
variable "ngw_id" {
  default = null
}