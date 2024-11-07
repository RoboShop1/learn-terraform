resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = merge({
      Name = "${var.env}-vpc"
    },local.common_tags)
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = merge({
      Name = "${var.env}-igw"
    },local.common_tags)
  }
}