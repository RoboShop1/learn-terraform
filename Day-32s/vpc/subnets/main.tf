resource "aws_subnet" "main" {

  for_each           = var.subnets
  vpc_id             = var.vpc_id
  cidr_block         = each.value["cidr_block"]
  availability_zone  = each.value["az"]
  tags = {
    Name = "${var.env}-vpc-subnet-${each.key}"
  }
}




resource "aws_route_table" "rt" {
  for_each   = aws_subnet.main
  vpc_id     = var.vpc_id

  tags = {
    Name = "${var.env}-vpc-rt-${each.key}"
  }
}


# resource "aws_route_table_association" "rta" {
#   for_each        =  aws_subnet.main
#   subnet_id       =  lookup(aws_subnet.main,each.value["id"],null)
#   route_table_id  = lookup(aws_route_table.rt,each.value["id"],null)
# }



variable "subnets" {}
variable "vpc_id" {}
variable "env" {}



output "subnets" {
  value = aws_subnet.main
}

output "rt-tables" {
  value = aws_route_table.rt
}