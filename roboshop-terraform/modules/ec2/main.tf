resource "aws_security_group" "sg" {
  vpc_id = var.vpc_id
  ingress{
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
resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id = var.subnet_id
  key_name = "nvirginia"

  tags = {
    Name = "demo-1"
  }
}