
provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  default = "ami-0b4f379183e5706b9"
}

resource "aws_instance" "sample" {
  count = 2
  ami = var.ami
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "dev-${count.index+1}"
  }
}