resource "aws_subnet" "main" {
  count      = length(var.subnets_cidr_blocks)

  vpc_id     = var.vpc_id
  cidr_block = element(var.subnets_cidr_blocks,count.index)

  tags = {
    Name = "${var.env}-${var.subnet_name}-${count.index}"
  }
}




















# resource "aws_subnet" "web_subnets" {
#   count      = length(var.web_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.web_cidr_blocks,count.index)
#
#   tags = {
#     Name = "web-${var.env}-subnet${count.index}"
#   }
# }
#
#
# resource "aws_subnet" "app_subnets" {
#   count      = length(var.app_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.app_cidr_blocks,count.index)
#
#
#   tags = {
#     Name = "app-${var.env}-subnet${count.index}"
#   }
# }
#
#
#
# resource "aws_subnet" "db_subnets" {
#   count      = length(var.db_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.db_cidr_blocks,count.index)
#
#   tags = {
#     Name = "db-${var.env}-subnet${count.index}"
#   }
# }



