resource "aws_instance" "main" {
    ami           = "ami-0ddc798b3f1a5117e"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg.id]

  tags = {
    Name = var.name
  }

}


variable "name" {}



resource "aws_security_group" "sg" {
  name        = "${var.name}-sg"
  description = "Allow ssh"
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

output "ec2" {
  value = aws_instance.main
}
output "sg" {
  value = aws_security_group.sg
}