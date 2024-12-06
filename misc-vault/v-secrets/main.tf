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

      }
      prod-env = {

      }


    }
    cart = {
      dev-env = {

      }
      prod-env = {

      }


    }
    user = {
      dev-env = {

      }
      prod-env = {

      }

    }
    shipping = {
      dev-env = {

      }
      prod-env = {

      }


    }
    payment = {
      dev-env = {

      }
      prod-env = {

      }

    }
  }
}


locals {
  keys = { for k,v in var.services: keys(k) => values(v) }
}

output "demo" {
  value = local.keys
}
# resource "vault_mount" "app_mount" {
#   for_each = var.services
#   path        = each.key
#   type        = "kv"
#   options     = { version = "2" }
#   description = "KV Version 2 Roboshop ${each.key}"
# }
#
#
# resource "vault_kv_secret_v2" "example" {
#   mount                      = vault_mount.app_mount.path
#   name                       = ""
#   cas                        = 1
#   delete_all_versions        = true
#   data_json                  = jsonencode(
#     {
#       zip       = "zap",
#       foo       = "bar"
#     }
#   )
#   custom_metadata {
#     max_versions = 5
#     data = {
#       foo = "vault@example.com",
#       bar = "12345"
#     }
#   }
# }
