resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-vpc-igw"
  }
}
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_vpc_id = aws_vpc.main.id
  vpc_id      = data.aws_vpc.default.id
}


resource "aws_subnet" "public_subnets" {
  count      = length(var.public_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env }-public${count.index}-${var.availability_zones[count.index]}"
    cidr_block = "${var.public_cidr_blocks[count.index]}"
  }
}

resource "aws_route_table" "rt" {
  count      = length(var.public_cidr_blocks)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.env }-public-rt-${count.index}"
  }
}

resource "aws_route_table_association" "rta" {
  count          = length(var.public_cidr_blocks)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.rt[count.index].id
}





resource "aws_subnet" "private_subnets" {
  count      = length(var.private_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.env }-private${count.index}-${var.availability_zones[count.index]}"
    cidr_block = "${var.private_cidr_blocks[count.index]}"
  }
}


resource "aws_route_table" "private_rt" {
  count      = length(var.private_cidr_blocks)
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env }-private-rt-${count.index}"
  }
}

resource "aws_route_table_association" "private_rta" {
  count          = length(var.private_cidr_blocks)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt[count.index].id
}








