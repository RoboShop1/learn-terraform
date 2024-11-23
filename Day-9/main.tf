module "asg" {
  for_each    = var.components

  source      = "./asg"
  component   = each.key
  app_ports   = each.value["app_ports"]

}


variable "components" {
  default = {
    frontend = {
      app_ports = [80, 443]
    }
    catalogue = {
      app_ports = [8080]
    }
  }
}