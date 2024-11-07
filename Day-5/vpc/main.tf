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

resource "aws_route" "default_route" {
  route_table_id = aws_vpc.main.default_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id

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

