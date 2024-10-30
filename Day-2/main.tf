resource "aws_instance" "sample" {
  count = 2
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "demo-${count.index}"
  }
}