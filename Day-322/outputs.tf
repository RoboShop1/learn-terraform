output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = module.vpc["dev"]["subnets_main"]
}