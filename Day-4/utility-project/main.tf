provider "aws" {
  region = "ap-south-1"
}

data "aws_availability_zones" "example" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

output "zones" {
  value = data.aws_availability_zones.example.names
}