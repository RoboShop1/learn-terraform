resource "aws_ec2_transit_gateway" "example" {
  description = "dev-prod-tg"
  tags = {
    Name = "dev-prod-tg"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  for_each           = var.vpc
  subnet_ids         = values(each.value["app_subnets"])
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  vpc_id             = each.value["vpc_id"]

  tags = {
    Name = "${each.key}-tg-attachment"
  }
}
