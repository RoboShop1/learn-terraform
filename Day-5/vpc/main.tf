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

# //////////////////
# Public-subnets ////
# /////////////////

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = merge({
    Name = "public-subnet${count.index+1}-${var.availability_zone[count.index]}-${var.public_subnets_cidr[count.index]}"
  },local.common_tags)
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public-rta" {
  count = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.public_subnets.*.id[count.index]
}


# //////////////////
# web-subnets ////
# /////////////////

resource "aws_subnet" "web_subnets" {
  count = length(var.web_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.web_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "web-subnet${count.index+1}-${var.availability_zone[count.index]}-${var.web_subnets_cidr[count.index]}"
  },local.common_tags)
}



# //////////////////
# app-subnets ////
# /////////////////

resource "aws_subnet" "app_subnets" {
  count = length(var.app_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.app_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "app-subnet${count.index+1}-${var.availability_zone[count.index]}${var.app_subnets_cidr[count.index]}"
  },local.common_tags)
}

# //////////////////
# db-subnets ////
# /////////////////

resource "aws_subnet" "db_subnets" {
  count = length(var.db_subnets_cidr)
  vpc_id = aws_vpc.main.id
  cidr_block = var.db_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = merge({
    Name = "db-subnet${count.index+1}-${var.availability_zone[count.index]}${var.db_subnets_cidr[count.index]}"
  },local.common_tags)
}















