output "vpc_main" {
  value = aws_vpc.main
}

output "subnets_main" {
  value = { for i,j in module.subnets: i => j.subnets }
}