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


#output "main" {
#  value = aws_instance.main.id
#}

output "main1" {
  value = aws_instance.main
}