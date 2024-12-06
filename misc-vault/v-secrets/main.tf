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
  for_each    = var.services
  path        = each.key
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 Roboshop ${each.key}"
}

output "all" {
  value = vault_mount.app_mount
}
resource "vault_kv_secret_v2" "env-dev" {
  for_each                   = vault_mount.app_mount

  mount                      = each.key
  name                       = "dev-env"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(lookup(lookup(var.services,"${each.key}","null"),"dev-env","null"))

}
