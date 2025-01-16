resource "aws_subnet" "main" {
  count      = length(var.subnets_cidr_blocks)

  vpc_id     = var.vpc_id
  cidr_block = element(var.subnets_cidr_blocks,count.index)

  tags = {
    Name = "${var.env}-${var.subnet_name}-${count.index}"
  }
}


resource "aws_route_table" "main" {
  vpc_id    =  var.vpc_id
  count     = length(aws_subnet.main)

  tags = {
    Name = "${var.env}-${var.subnet_name}-rt-${count.index}"
  }
}

resource "aws_route_table_association" "rta" {
  count          = length(aws_subnet.main)
  subnet_id      = element(aws_subnet.main,count.index)["id"]
  route_table_id = aws_route_table.main.*.id[count.index]
}


resource "aws_eip" "eip" {
  count              = var.subnet_name == "public-subnets" ? length(var.subnets_cidr_blocks): 0
  domain             = "vpc"
}


resource "aws_nat_gateway" "nat-gw" {

  count              = var.subnet_name == "public-subnets" ? length(var.subnets_cidr_blocks): 0
  allocation_id      = element(aws_eip.eip.*.id,count.index)

  subnet_id          = aws_subnet.main.*.id[count.index]

  tags = {
    Name = "gw NAT"
  }

}


# resource "aws_route" "nat-route" {
#   count                     = var.nat_route ? length(aws_route_table.main): 0
#   route_table_id            = element(aws_route_table.main.*.id,count.index)
#
#   destination_cidr_block    = "0.0.0.0/0"
#   nat_gateway_id            = aws_nat_gateway.nat-gw.*.id[count.index]
# }

















# resource "aws_subnet" "web_subnets" {
#   count      = length(var.web_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.web_cidr_blocks,count.index)
#
#   tags = {
#     Name = "web-${var.env}-subnet${count.index}"
#   }
# }
#
#
# resource "aws_subnet" "app_subnets" {
#   count      = length(var.app_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.app_cidr_blocks,count.index)
#
#
#   tags = {
#     Name = "app-${var.env}-subnet${count.index}"
#   }
# }
#
#
#
# resource "aws_subnet" "db_subnets" {
#   count      = length(var.db_cidr_blocks)
#
#   vpc_id     = var.vpc_id
#   cidr_block = element(var.db_cidr_blocks,count.index)
#
#   tags = {
#     Name = "db-${var.env}-subnet${count.index}"
#   }
# }



