resource "aws_vpc" "main" {
  cidr_block    = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}


module "subnets" {
  depends_on         = [aws_vpc.main.id]

  source             = "./subnets"

  env                = var.env
  public_cidr_blocks = var.public_cidr_blocks
  web_cidr_blocks    = var.web_cidr_blocks
  app_cidr_blocks    = var.app_cidr_blocks
  db_cidr_blocks     = var.db_cidr_blocks
  vpc_id             = aws_vpc.main.id
}


