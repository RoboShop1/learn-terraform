terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {
  owner = "RoboShop1"
  token = var.token
}
variable "token" {}

variable "env" {
  default = ["dev","qa","uat","prof"]
}

data "github_user" "current" {
  username = "chaithanya1812"
}
resource "github_repository_environment" "example" {
  for_each = toset(var.env)
  environment         = each.key
  repository          = "r-cart"
  prevent_self_review = false
  reviewers {
    users = [data.github_user.current.id]
  }
}

#data "github_repository" "example" {
#  name =  "r-cart"
#}
#
#output "demo" {
#  value = data.github_repository.example.http_clone_url
#}