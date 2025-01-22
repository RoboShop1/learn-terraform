packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}





variable "region" {
  default = "us-east-1"
}

source "amazon-ebs" "nginx" {
  ami_name      = "learn-terraform-packer-v1"
  instance_type = "t3.small"
  region        = var.region
  source_ami    = "ami-0df8c184d5f6ae949"
  ssh_username = "ec2-user"

  subnet_id = "subnet-0071e36c53f811c0b"



  launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 5
    volume_type = "gp2"
    delete_on_termination = true
  }

  force_deregister = true
  force_delete_snapshot = true

  run_tags = {
    Name = "PackerBuildInstance"
  }
}


build {
  sources = ["source.amazon-ebs.nginx"]
  provisioner "shell" {
    script = "setup.sh"
  }
}