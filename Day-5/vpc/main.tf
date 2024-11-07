resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge({
      Name = "${var.env}-vpc"
    },local.common_tags)
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = merge({
      Name = "${var.env}-igw"
    },local.common_tags)
}


resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "public-subnet${count.index+1}-${var.availability_zone[count.index]}"
  },local.common_tags)
}


resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = "0.0.0.0/0"
  security_group_id = aws_vpc.main.default_security_group_id
}