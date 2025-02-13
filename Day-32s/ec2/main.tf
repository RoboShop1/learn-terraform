resource "aws_instance" "main" {
  ami = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  subnet_id = var.subnet_id
}

variable "subnet_id" {}