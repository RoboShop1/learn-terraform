variable "ports" {
  default = {
    port1 = {
      port = 80
      cidr_block =  ["0.0.0.0/0"]
    }
    port2 = {
      port = 8080
      cidr_block =  ["0.0.0.0/0"]
    }
  }
}

variable "ports1" {
  default = [80,9090]
}
resource "aws_security_group" "allow_tls" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_tls"
  }

  dynamic "ingress" {
    for_each = toset(var.ports1)
    content {
      from_port        = ingress.value.value
      to_port          = ingress.value.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}



data "aws_vpc" "default" {
default = true
}