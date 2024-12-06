provider "vault" {
  address = "https://172.31.33.80:8200"
  token   = var.token
  skip_tls_verify = true
}

variable "token" {}