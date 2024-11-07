variable "env" {}

variable "vpc_cidr" {}
variable "public_subnets_cidr" {
  default = null
}
variable "web_subnets_cidr" {
  default = null
}
variable "app_subnets_cidr" {
  default = null
}
variable "db_subnets_cidr" {
  default = null
}