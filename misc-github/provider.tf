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

data "github_repository" "example" {
  name =  "r-cart"
}