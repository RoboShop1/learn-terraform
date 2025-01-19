packer {
  required_plugins {
    happycloud = {
      version = ">= 2.7.0"
      source = "github.com/hashicorp/happycloud"
    }
  }
}


source "azure-arm" "community_image" {

  tenant_id                      = "45d57a10-6a53-49fd-8f5a-bc35cf01d08b"
  subscription_id                = "12f9be95-f674-4dc3-8c29-d915cc4e1f8e"

  managed_image_resource_group_name = "iteration-1"
  managed_image_name                = "customImageFromCommunity"
  location                          = "UK West"

  # Direct reference to a Community Image using its URN
  communities_image_id = "/subscriptions/7b6c642c-6e46-418f-b715-e01b2f871413/resourceGroups/trail1/providers/Microsoft.Compute/galleries/LDOTrail/images/rhel9-devops-practice/versions/04.12.2024"
}

build {
  name    = "Azure Community Image Build"
  sources = ["source.azure-arm.community_image"]

  provisioner "shell" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo rm -rf /usr/share/nginx/html/*",
      "sudo echo 'This is chaithanya' >  /usr/share/nginx/html/index.html",
      "sudo systemctl status nginx"
    ]
  }
}

