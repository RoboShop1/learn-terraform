output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_sample" {
  value = [ for subnets in aws_subnet.public_subnets: subnets.id ]
}

output "default_vpc" {
  value = data.aws_vpc.default
}