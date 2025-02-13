module "mysql" {
  source = "./modules/mysql"
}


module "ec2" {
  depends_on = [module.document]
  source = "./modules/ec2"
}

module "document" {
  source = "./modules/documentdb"
}


# variable "mapp" {
#   default = {
#     key1 = "value1"
#     key2 = "value2"
#     key3 = "value3"
#   }
# }
#
# output "final" {
#   value = <<EOT
# %{~for i,j in var.mapp ~}
# ${i}-${j},
# %{~ endfor ~}
# EOT
# }

variable "names" {
  default = {
    name = "chaitu11111"
    name1 = "chaitu2"
  }
}
output "main" {
  value = templatefile("one.txt",var.names )
}