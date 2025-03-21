packer {
  required_plugins {
    azure = {
      version = ">= 1.8.0" # Use the latest version for new features
      source  = "github.com/hashicorp/azure"
    }
  }
}

source "azure-arm" "community_image" {


  managed_image_resource_group_name = "iteration-1"
  managed_image_name                = "customImageFromCommunity"
  location                          = "UK West"

  # Direct reference to a Community Image using its URN
  #communities_image_id = "/subscriptions/7b6c642c-6e46-418f-b715-e01b2f871413/resourceGroups/trail1/providers/Microsoft.Compute/galleries/LDOTrail/images/rhel9-devops-practice/versions/04.12.2024"

  os_type           = "Linux"
  image_publisher   = "Canonical"
  image_offer       = "rhel9-devops-practice"
  image_sku         = "04.12.2024"
  image_version     = "latest" # Optional, defaults to latest
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

