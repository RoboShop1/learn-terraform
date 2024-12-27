provider "aws" {
  region = "us-east-1"
}

variable "dev_subnets" {
  default = ["subnet-0a02de54972fc07ce","subnet-06dcbcef454ba0730"]
}

resource "aws_instance" "dev" {
  count = length(var.dev_subnets)
  ami = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  subnet_id = var.dev_subnets[count.index]


  tags = {
    Name  = "dev-${count.index}"
  }
}



variable "prod_subnets" {
  default = ["subnet-0623e5af9ee103f1f","subnet-00da3a1e8346fcbea"]
}

resource "aws_instance" "prod" {
  count = length(var.prod_subnets)
  ami = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  subnet_id = var.prod_subnets[count.index]

  tags = {
    Name  = "Prod-${count.index}"
  }
}


resource "aws_vpc_security_group_ingress_rule" "dev-rule" {
  security_group_id = "sg-0224bec37138516d9"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_ingress_rule" "prod-rule" {
  security_group_id = "sg-08f3091bc8d189451"

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}