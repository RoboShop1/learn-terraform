output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = lookup(lookup(module.vpc,"dev",null),"subnets_main",null)
}