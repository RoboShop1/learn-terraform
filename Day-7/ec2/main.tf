resource "aws_instance" "main" {
  ami           = "ami-0984f4b9e98be44bf"
  instance_type = "t2.micro"
  associate_public_ip_address = var.associate_public_ip_address == 1 ? true: false
  subnet_id = var.subnet_id
  key_name = "nvirginia"
  tags   = {
    Name = var.name
  }
}

variable "name" {}
variable "associate_public_ip_address" {}
variable "subnet_id" {}