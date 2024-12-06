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
  for_each = var.services
  path        = each.key
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 Roboshop ${each.key}"
}


resource "vault_kv_secret_v2" "env-dev" {
  for_each                   = var.services
  mount                      = vault_mount.app_mount.path
  name                       = "env-dev"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(each.value["env-dev"])
  custom_metadata {
    max_versions = 5
    data = {
      foo = "vault@example.com",
      bar = "12345"
    }
  }
}
