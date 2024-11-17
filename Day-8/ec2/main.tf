resource "aws_ec2_transit_gateway" "transit" {
  tags = {
    Name = "cgit-transit"
  }
}