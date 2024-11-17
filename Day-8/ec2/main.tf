resource "aws_ec2_transit_gateway" "transit" {
  tags = {
    Name = "cgit-transit"
  }
}

#resource "aws_ec2_transit_gateway_vpc_attachment" "dev-vpc-private" {
#  subnet_ids         = ["subnet-0e7abd07665847a17","subnet-020e399f2d3bf0e95"]
#  transit_gateway_id = aws_ec2_transit_gateway.transit.id
#  vpc_id             = "vpc-0cdf0504e5f63fd78"
#}
#
#resource "aws_ec2_transit_gateway_vpc_attachment" "dev-vpc-public" {
#  subnet_ids         = ["subnet-08ac43eb519942608","subnet-0b508cd091db5da8e"]
#  transit_gateway_id = aws_ec2_transit_gateway.transit.id
#  vpc_id             = "vpc-0cdf0504e5f63fd78"
#}
#
#resource "aws_ec2_transit_gateway_connect" "dev-vpc-p" {
#  transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.dev-vpc-private.id
#  transit_gateway_id      = aws_ec2_transit_gateway.transit.id
#
#  tags = {
#    Name = "dev-vpc-connect"
#  }
#}
#
#resource "aws_ec2_transit_gateway_connect" "dev-vpc-public" {
#  transport_attachment_id = aws_ec2_transit_gateway_vpc_attachment.dev-vpc-public.id
#  transit_gateway_id      = aws_ec2_transit_gateway.transit.id
#
#  tags = {
#    Name = "dev-vpc-connect"
#  }
#}
