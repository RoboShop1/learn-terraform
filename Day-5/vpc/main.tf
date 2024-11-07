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

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.main.default_security_group_id
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

resource "aws_route_table" "rt-main" {
  count = length(aws_subnet.public_subnets)

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-rt${count.index+1}"
  }
}

resource "aws_route_table_association" "rt-a" {
  count = length(aws_route_table.rt-main)
  route_table_id = aws_route_table.rt-main[count.index].id
  subnet_id = aws_subnet.public_subnets[count.index].id
}

output "rt" {
  value = aws_route_table.rt-main
}




























