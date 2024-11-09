resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name[count.index+1]}-${var.cidr_block[count.index]}-${var.availability_zones[count.index]}"
  }
}

