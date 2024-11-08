resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "vpc-${var.name}"
  }
}

output "vpc" {
  value = {
    for key, value in aws_vpc.main: key => value.id
  }
}