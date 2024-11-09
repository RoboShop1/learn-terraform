resource "aws_subnet" "main" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block
  availability_zone = var.availability_zones

  tags = {
    Name = "${var.name}-${var.cidr_block}-${var.availability_zones}"
  }
}

