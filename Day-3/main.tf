module "ec2" {
  for_each = var.components
  source = "./modules/ec2"
  name  = var.components[each.key]["name"]
}


variable "components" {
  default = {

    web = {
      name = "web"
    }
    backend = {
      name = "backend"
    }
    mysql = {
      name = "mysql"
    }
  }
}

output "all_one" {
  value = module.ec2.all
}