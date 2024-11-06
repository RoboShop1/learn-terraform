resource "aws_instance" "main" {
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "demo2"
    project = "roboshop"
  }
}