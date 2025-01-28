
output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = { for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" }
}


resource "aws_instance" "main" {
  for_each = { for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" }
  ami           = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  subnet_id     = each.value
}