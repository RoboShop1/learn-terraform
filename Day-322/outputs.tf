output "vpc" {
  value = module.vpc
}

output "app_subnets" {
  value = module.vpc.subnets_main
}