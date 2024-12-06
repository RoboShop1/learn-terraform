variable "services" {
  default = {
    frontend = {
      dev-env = {
        app = "dev"
      }
      prod-env = {
        app = "prod"
      }
    }
    catalogue = {
      dev-env = {
        app = "dev"
      }
      prod-env = {
        app = "prod"
      }
    }
  }
}




resource "vault_mount" "app_mount" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 Roboshop"
}

output "all" {
  value = vault_mount.app_mount
}
resource "vault_kv_secret_v2" "env-dev" {
  for_each                   = var.services

  mount                      = vault_mount.app_mount.path
  name                       = each.key
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(lookup(each.value,"dev-env","null"))

}
