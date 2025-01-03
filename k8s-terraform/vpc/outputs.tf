output "public_subnets" {
  value = aws_subnet.public-subnets.*.id
}

output "private_subnets" {
  value = aws_subnet.private-subnets.*.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}