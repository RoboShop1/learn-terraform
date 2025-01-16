resource "aws_subnet" "public_subnets" {
  count      = length(var.public_cidr_blocks)
  vpc_id     = var.vpc_id
  cidr_block = element(var.public_cidr_blocks,count.index)

  tags = {
    Name = "public-${var.env}-subnets"
  }
}

resource "aws_subnet" "web_subnets" {
  count      = length(var.web_cidr_blocks)
  vpc_id     = var.vpc_id
  cidr_block = element(var.web_cidr_blocks,count.index)

  tags = {
    Name = "web-${var.env}-subnets"
  }
}


resource "aws_subnet" "app_subnets" {
  count      = length(var.app_cidr_blocks)
  vpc_id     = var.vpc_id
  cidr_block = element(var.app_cidr_blocks,count.index)


  tags = {
    Name = "app-${var.env}-subnets"
  }
}



resource "aws_subnet" "db_subnets" {
  count      = length(var.db_cidr_blocks)
  vpc_id     = var.vpc_id
  cidr_block = element(var.db_cidr_blocks,count.index)

  tags = {
    Name = "db-${var.env}-subnets"
  }
}

