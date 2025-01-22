data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "learn-terraform-packer-v1"
  owners           = ["self"]
}


output "name" {
  value = data.aws_ami.example
}


resource "aws_instance" "main" {
  instance_type = "t2.micro"
  ami = data.aws_ami.example.image_id
  key_name = "nvirginia"

  tags  = {
    Name = "sample-tag"
  }
}