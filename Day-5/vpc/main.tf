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
    Name = "public-subnet${count.index+1}-${var.availability_zone[count.index]}-${var.public_subnets_cidr[count.index]}"
  },local.common_tags)
}


resource "aws_subnet" "web_subnets" {
  count = length(var.web_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.web_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "web-subnet${count.index+1}-${var.availability_zone[count.index]}-${var.web_subnets_cidr[count.index]}"
  },local.common_tags)
}

resource "aws_subnet" "app_subnets" {
  count = length(var.app_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.app_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "app-subnet${count.index+1}-${var.availability_zone[count.index]}${var.app_subnets_cidr[count.index]}"
  },local.common_tags)
}


resource "aws_subnet" "db_subnets" {
  count = length(var.db_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.db_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "app-subnet${count.index+1}-${var.availability_zone[count.index]}${var.db_subnets_cidr[count.index]}"
  },local.common_tags)
}



























