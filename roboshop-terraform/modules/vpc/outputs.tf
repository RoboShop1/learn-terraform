output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "public_sample" {
  value = [ for subnets in aws_subnet.public_subnets: subnets.id ]
}