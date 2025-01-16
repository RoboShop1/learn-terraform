output "subnets" {
  value = aws_subnet.main
}

output "nat" {
  value = aws_nat_gateway.nat-gw
}