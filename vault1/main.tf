#
# provider "vault" {
#   address = "http://44.197.238.225:8200/"
#   skip_tls_verify = true
#   token = var.token
# }
#
# variable "token" {}
#
# data "vault_kv_secret" "secret_data" {
#   path = "k8s/data/cart"
# }
#
#
# output "data1" {
#   value = jsonencode(data.vault_kv_secret.secret_data.data_json)
#   sensitive = true
# }
#
#
#
#
# resource "null_resource" "main5" {
#   provisioner "remote-exec" {
#     connection {
#       type = "ssh"
#       user = "centos"
#       password = "${jsondecode(data.vault_kv_secret.secret_data.data["data"])["password"]}"
#       host = "172.31.10.218"
#     }
#     inline = [
#     "echo Hello world"
#     ]
#   }
# }
#
#
#
#
# resource "null_resource" "main7" {
#   provisioner "remote-exec" {
#     connection {
#       type = "ssh"
#       user = "centos"
#       password = "${jsondecode(data.vault_kv_secret.secret_data.data_json)["data"]["password"]}"
#       host = "172.31.10.218"
#     }
#     inline = [
#       "echo Hello world"
#     ]
#   }
# }

# resource "null_resource" "main" {
#   triggers = {
#     name = timestamp()
#   }
#
# provisioner "local-exec" {
#   command = <<EOT
#
# echo ${jsonencode(data.vault_kv_secret.secret_data.data)} > 1.txt
# echo ${jsondecode(data.vault_kv_secret.secret_data.data_json)["name1"]} > 2.txt
# EOT
# }
# }
#
# output "name1" {
#   value = jsondecode(data.vault_kv_secret.secret_data.data["data"])["name1"]
#   sensitive = true
# }




output "one" {
  value = jsondecode(file("1.json"))
}

output "two" {
  value = jsondecode(file("1.json"))["data"]
}