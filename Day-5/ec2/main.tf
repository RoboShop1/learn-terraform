resource "aws_instance" "main" {
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = "nvirginia"

  tags = {
    Name = "${var.name}"
  }
}

variable "name" {}
variable "subnet_id" {}