resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}


resource "aws_security_group_rule" "rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.main.default_security_group_id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-vpc-igw"
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets.*.id[0]

  tags = {
    Name =  "${var.env}-vpc-nat"
  }
  depends_on = [aws_internet_gateway.gw]
}



resource "aws_subnet" "public_subnets" {
  count      = length(var.public_subnets_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.env}-public-subnet${count.index+1}"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.env}-public-rt"
  }
}


resource "aws_route_table_association" "public-rta" {
  count          = length(aws_subnet.public_subnets)
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public_subnets[count.index].id
}




resource "aws_subnet" "private_subnets" {
  count      = length(var.private_subnets_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets_cidr_blocks[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.env}-private-subnet${count.index+1}"
  }
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "private-rta" {
  count          = length(aws_subnet.private_subnets)
  route_table_id = aws_route_table.private-rt.id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

