
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
  value = data.vault_kv_secret.secret_data
  sensitive = true
}

resource "null_resource" "main2" {
  triggers = {
    name = timestamp()
  }
  provisioner "local-exec" {
    command =<<EOT
touch /tmp/3.txt
echo ${data.vault_kv_secret.secret_data.data_json} | jq .
EOT
  }
}