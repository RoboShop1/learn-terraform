resource "aws_subnet" "main" {
  count = length(var.cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = var.cidr_block[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "${var.name}${count.index+1}-${var.cidr_block[count.index]}-${var.availability_zones[count.index]}"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-rt"
  }
}


resource "aws_route_table_association" "rt-a" {
  count          = length(aws_subnet.main)
  subnet_id      =  aws_subnet.main[count.index].id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route" "igw" {
  count                     = var.igw ? 1 : 0
  route_table_id            = aws_route_table.rt.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = var.igw_id
}

resource "aws_route" "ngw" {
  count                     = var.nat ? 1 : 0
  route_table_id            = aws_route_table.rt.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = var.ngw_id
}


output "subnets_ids" {
  value = aws_subnet.main.*.id
}

output "subnets_1" {
  value = aws_subnet.main
}