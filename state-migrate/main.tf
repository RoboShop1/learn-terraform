terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }

  backend "s3" {
    bucket = "chaituample"
    key = "migrate"
  }
}

resource "aws_instance" "main" {
  ami = "ami-04aa00acb1165b32a"
  instance_type = "t2.micro"

  tags = {
    Name = "sample"
  }
}