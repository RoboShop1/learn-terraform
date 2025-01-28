
output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = { for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" }
}

output "values" {
  value = values({ for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" })
}

locals {
  name = values({ for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" })
}

output "rr" {
  value = local.name
}

# resource "aws_instance" "main" {
#   for_each = toset(values({ for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" }))
#   ami           = "ami-0b4f379183e5706b9"
#   instance_type = "t2.micro"
#   subnet_id     = each.value
#
# }