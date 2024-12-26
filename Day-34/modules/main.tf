resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

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



// public-subnets..

resource "aws_subnet" "public_subnet" {
  count              = length(var.public_subnet_cidr_blocks)

  vpc_id             = aws_vpc.main.id
  cidr_block         = elemet(var.public_subnet_cidr_blocks,count.index)
  availability_zone  = element(var.public_availability_zones,count.index)

  tags = {
    Name = "${var.env}-public-subnet-${count.index}"
  }
}

resource "aws_route_table" "public_rtb" {
  count           = length(aws_subnet.public_subnet)
  vpc_id          = aws_vpc.main.id


  route {
    cidr_block = "0.0.0.0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rtb-${count.index}"
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = elemet(aws_subnet.public_subnet,count.index)
  route_table_id = elemet(aws_route_table.public_rtb,count.index)
}

//


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

  subnet_id      = elemet(aws_subnet.web_subnet,count.index)
  route_table_id = elemet(aws_route_table.web_rtb,count.index)
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

  subnet_id      = elemet(aws_subnet.app_subnet,count.index)
  route_table_id = elemet(aws_route_table.app_rtb,count.index)
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

  subnet_id      = elemet(aws_subnet.db_subnet,count.index)
  route_table_id = elemet(aws_route_table.db_rtb,count.index)
}


