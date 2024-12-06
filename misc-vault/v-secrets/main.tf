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
        MONGO = true
        MONGO_URL = "mongodb://database.azcart.online:27017/catalogue"
      }
      prod-env = {

      }
    }
    user = {
      dev-env = {
        MONGO = true
        REDIS_URL = "redis://database.azcart.online:6379"
        MONGO_URL = "mongodb://database.azcart.online:27017/users"
      }
      prod-env = {

      }
    }
    cart = {
      dev-env = {
        REDIS_HOST =  "database.azcart.online"
        CATALOGUE_HOST = "catalogue"
        CATALOGUE_PORT = 8080
      }
      prod-env = {

      }
    }
    shipping = {
      dev-env = {
        CART_ENDPOINT = "cart:8080"
        DB_HOST = "database.azcart.online"
      }
      prod-env = {

      }
    }
    payment = {
      dev-env = {
         CART_HOST = "cart"
         CART_PORT = 8080
         USER_HOST = "user"
         USER_PORT = 8080
         AMQP_HOST = "database.azcart.online"
         AMQP_USER = "roboshop"
         AMQP_PASS = "roboshop123"
      }
      prod-env = {

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
