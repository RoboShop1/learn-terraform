data "aws_vpc" "default" {
  default = true
}
resource "aws_iam_role" "main" {
  name = "${var.component}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "main_policy" {
  name = "ec2-policy"
  role = aws_iam_role.main.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_instance_profile" "main_profile" {
  name = "${var.component}_profile"
  role = aws_iam_role.main.name
}



resource "aws_security_group" "main" {
  name        = "${var.component}-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_tls"
  }

  dynamic "ingress" {
    for_each = toset(var.app_ports)
    content {
      from_port        = ingress.value
      to_port          = ingress.value
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



resource "aws_launch_template" "main" {
  name = "${var.component}-template"
  image_id = "ami-0453ec754f44f9a4a"
  instance_type = "t2.micro"
  key_name = "nvirginia"
  vpc_security_group_ids = [aws_security_group.main.id]

  iam_instance_profile {
    name = aws_iam_instance_profile.main_profile.name
  }
}






























