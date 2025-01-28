output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = { for i,k in lookup(lookup(module.vpc,"dev",null),"subnets_main",null): i => k if i == "app" }
}