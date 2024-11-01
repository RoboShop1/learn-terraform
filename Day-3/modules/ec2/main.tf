resource "aws_instance" "main" {
    ami           = "ami-0ddc798b3f1a5117e"
    instance_type = "t2.micro"

  tags = {
    Name = var.name
  }

}

variable "name" {}

output "all" {
  value = aws_instance.main
}