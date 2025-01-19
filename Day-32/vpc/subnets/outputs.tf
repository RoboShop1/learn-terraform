output "subnets" {
  value = { for i,k in aws_subnet.main: i => k.id }
}