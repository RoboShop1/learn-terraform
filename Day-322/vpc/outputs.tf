output "vpc_main" {
  value = aws_vpc.main
}

output "subnets_main" {
  value = module.subnets
}