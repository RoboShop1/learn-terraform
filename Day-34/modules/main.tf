terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
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
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.env}-vpc-nat"
  }
  depends_on = [aws_internet_gateway.igw]
}



// public-subnets..

resource "aws_subnet" "public_subnet" {
  count              = length(var.public_subnet_cidr_blocks)

  vpc_id             = aws_vpc.main.id
  cidr_block         = element(var.public_subnet_cidr_blocks,count.index)
  availability_zone  = element(var.public_availability_zones,count.index)

  tags = {
    Name = "${var.env}-public-subnet-${count.index}"
  }
}

resource "aws_route_table" "public_rtb" {
  count           = length(aws_subnet.public_subnet)
  vpc_id          = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rtb-${count.index}"
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = element(aws_route_table.public_rtb.*.id,count.index)
}

////////////////////////


// web_subnets...

resource "aws_subnet" "web_subnet" {
  count             = length(var.web_subnet_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet_cidr_blocks[count.index]
  availability_zone = element(var.web_availability_zones,count.index)

  tags = {
    Name = "${var.env}-web-subnet-${count.index}"
  }
}

resource "aws_route_table" "web_rtb" {
  count           = length(aws_subnet.web_subnet)
  vpc_id          = aws_vpc.main.id

  tags = {
    Name = "${var.env}-web-rtb-${count.index}"
  }
}

resource "aws_route_table_association" "web_rta" {
  count          = length(aws_subnet.web_subnet)

  subnet_id      = element(aws_subnet.web_subnet.*.id,count.index)
  route_table_id = element(aws_route_table.web_rtb.*.id,count.index)
}

// app_subnets..

resource "aws_subnet" "app_subnet" {
  count             =  length(var.app_subnet_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.app_subnet_cidr_blocks,count.index)
  availability_zone = element(var.app_availability_zones,count.index)

  tags = {
    Name = "${var.env}-app-subnet-${count.index}"
  }
}



resource "aws_route_table" "app_rtb" {
  count           = length(aws_subnet.app_subnet)
  vpc_id          = aws_vpc.main.id

  tags = {
    Name = "${var.env}-app-rtb-${count.index}"
  }
}

resource "aws_route_table_association" "ap_rta" {
  count          = length(aws_subnet.app_subnet)

  subnet_id      = element(aws_subnet.app_subnet.*.id,count.index)
  route_table_id = element(aws_route_table.app_rtb.*.id,count.index)
}


//  db_subnets...

resource "aws_subnet" "db_subnet" {
  count             = length(var.db_subnet_cidr_blocks)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_subnet_cidr_blocks,count.index)
  availability_zone = element(var.db_availability_zones,count.index)

  tags = {
    Name = "${var.env}-db-subnet-${count.index}"
  }
}

resource "aws_route_table" "db_rtb" {
  count           = length(aws_subnet.db_subnet)
  vpc_id          = aws_vpc.main.id

  tags = {
    Name = "${var.env}-db-rtb-${count.index}"
  }
}



resource "aws_route_table_association" "db_rta" {
  count          = length(aws_subnet.app_subnet)

  subnet_id      = element(aws_subnet.db_subnet.*.id,count.index)
  route_table_id = element(aws_route_table.db_rtb.*.id,count.index)
}


