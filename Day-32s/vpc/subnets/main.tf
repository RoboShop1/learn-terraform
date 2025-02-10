resource "aws_subnet" "main" {

  for_each           = var.subnets
  vpc_id             = var.vpc_id
  cidr_block         = each.value["cidr_block"]
  availability_zone  = each.value["az"]
  tags = {
    Name = "${var.env}-vpc-subnet-${each.key}"
  }
}

variable "subnets" {}
variable "vpc_id" {}
variable "env" {}



output "subnets" {
  value = aws_subnet.main
}