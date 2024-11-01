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

output "all" {
  value = {
    for key, value in module.ec2: key => value.ec2.public_ip
  }
}