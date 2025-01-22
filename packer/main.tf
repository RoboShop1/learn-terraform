data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "learn-terraform-packer-v1"
  owners           = ["self"]
}


output "name" {
  value = data.aws_ami.example
}


resource "aws_instance" "main" {
  count        = 3
  instance_type = "t3.small"
  ami = "ami-09f49ac1793f38340"
  key_name = "nvirginia"

  lifecycle {
    create_before_destroy = true
  }

  tags  = {
    Name = "sample-tag-${count.index}"
  }
}