
provider "vault" {
  address = "http://44.197.238.225:8200/"
  skip_tls_verify = true
  token = var.token
}

variable "token" {}

data "vault_kv_secret" "secret_data" {
  path = "k8s/data/cart"
}


output "data1" {
  value = data.vault_kv_secret.secret_data.data["name1"]
  sensitive = true
}


