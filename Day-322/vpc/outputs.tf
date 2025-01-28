output "vpc_main" {
  value = aws_vpc.main
}

output "subnets_main" {
  value = { for i,j in module.subnets: i => { for m,n in j.subnets: m => n.id }  }
}

#