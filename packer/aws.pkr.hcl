packer {
  required_plugins {
    happycloud = {
      version = ">= 2.7.0"
      source = "github.com/hashicorp/aws"
    }
  }
}






variable "region" {
  default = "us-east-1"
}

source "amazon-ebs" "nginx" {
  ami_name      = "learn-terraform-packer-${local.timestamp}"
  instance_type = "t3.small"
  region        = var.region
  source_ami    = "ami-0df8c184d5f6ae949"
  ssh_username = "ec2-user"

  subnet_id = "subnet-066877464a2626291"

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