variable "env" {}

variable "vpc_cidr_block" {}

variable "public_subnet_cidr_blocks" {}
variable "web_subnet_cidr_blocks" {}
variable "app_subnet_cidr_blocks" {}
variable "db_subnet_cidr_blocks" {}

variable "db_availability_zones" {}
variable "app_availability_zones" {}
variable "web_availability_zones" {}
variable "public_availability_zones" {}


variable "peer_cidr_block" {}

variable "transit_gateway_id" {}