resource "aws_instance" "main" {
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  key_name      = "nvirginia"
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group" "main" {
  vpc_id = var.vpc_id
  ingress {
    from_port        = var.app_ports
    to_port          = var.app_ports
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags ={
    Name = "${element(split("-",var.name),0)}-sg"
  }
}

variable "name" {}
variable "subnet_id" {}
variable "app_ports" {}
variable "vpc_id" {}