resource "aws_subnet" "main" {
  for_each          = var.subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["az"]

  tags = {
    Name = "${var.env}-${each.key}}"
  }
}

variable "vpc_id" {}
variable "env" {}
variable "subnets" {}

output "subnets" {
  value = aws_subnet.main
}