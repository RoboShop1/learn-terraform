resource "aws_instance" "main" {
  ami    = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.name
  }
}

variable "name" {}
variable "ami" {}
variable "instance_type" {}