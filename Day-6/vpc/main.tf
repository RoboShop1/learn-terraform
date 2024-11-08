resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "vpc-${var.name}"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}