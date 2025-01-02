provider "aws" {
  region = "us-east-1"
}

variable "instances" {
  default = ["db","web","app"]
}
resource "aws_instance" "main" {
  count = length(var.instances)
  ami = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"

  tags = {
    Name = var.instances[count.index]
  }
}

output "of_list" {
  value = aws_instance.main[0]["id"]
}