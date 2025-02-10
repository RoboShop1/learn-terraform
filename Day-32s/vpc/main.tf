terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

variable "env" {}
variable "vpc_cidr_block" {}
variable "subnets" {}

module "subnets" {

  depends_on = [aws_vpc.main]

  for_each   = var.subnets
  source     = "./subnets"
  subnets    = each.value
  vpc_id     = aws_vpc.main.id
  env        =  var.env
}





locals {
  public_subnets = lookup({for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "public" },"public",null)
  web_subnets    = {for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "web" }
  app_subnets    = {for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "app" }
  db_subnets     = {for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } if i == "db" }
}



output "p" {
  value = local.public_subnets
}

resource "null_resource" "main" {
  for_each = values(local.public_subnets)

}


# output "subnets" {
#   value = {for i,j in module.subnets: i => {for m,n in j.subnets: m => n.id } }
# }
#
# # output "rt" {
# #   value = {for i,j in module.subnets: i => j}
# # }
#
# output "sample" {
#   value = module.subnets
# }