resource "aws_subnet" "main" {
  for_each   = var.subnets
  vpc_id     = var.vpc_id
  cidr_block = each.value["cidr"]
  availability_zone = each.value["az"]

  tags = {
    Name = "${var.env}-${each.key}-subnet"
  }
}

variable "env" {}
variable "vpc_id" {}
variable "subnets" {}


output "in_sub" {
  value = aws_subnet.main
}