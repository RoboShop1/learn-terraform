resource "aws_subnet" "main" {
  count  = length(var.cidr_block)
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.name}-${var.availability_zone[count.index]}"
  }
}

variable "cidr_block" {}
variable "vpc_id" {}
variable "availability_zone" {}
variable "name" {}