resource "aws_ec2_transit_gateway" "dev-to-prod" {
  description = "dev-vpc-to-prod-vpc"

  tags = {
    Name = "dev-vpc-to-prod-vpc"
  }
}

variable "dev_subnets" {
  default = ["subnet-0a02de54972fc07ce","subnet-09f63215a7fb78292"]
}



# resource "aws_ec2_transit_gateway_vpc_attachment" "dev-vpc-attach1" {
#
#   subnet_ids         = [var.dev_subnets[0]]
#   transit_gateway_id = aws_ec2_transit_gateway.dev-to-prod.id
#   vpc_id             = "vpc-0878f6ef79e3c3551"
#
#   tags = {
#     Name  = "dev-vpc-attachment0"
#   }
# }
#
#
# resource "aws_ec2_transit_gateway_vpc_attachment" "dev-vpc-attach2" {
#
#   subnet_ids         = [var.dev_subnets[1]]
#   transit_gateway_id = aws_ec2_transit_gateway.dev-to-prod.id
#   vpc_id             = "vpc-0878f6ef79e3c3551"
#
#   tags = {
#     Name  = "dev-vpc-attachment1"
#   }
#}


resource "aws_ec2_transit_gateway_vpc_attachment" "dev-vpc-attach" {
  transit_gateway_id = aws_ec2_transit_gateway.dev-to-prod.id
  vpc_id             = "vpc-0878f6ef79e3c3551"
  subnet_ids         = ["subnet-0a02de54972fc07ce","subnet-09f63215a7fb78292"]

  tags = {
    Name = "dev-tgw-vpc-attachment"
  }
}
