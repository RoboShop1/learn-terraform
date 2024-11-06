resource "aws_instance" "main" {
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t3.micro"
  availability_zone = "us-east-1c"

  tags = {
    Name = "demo2"
    project = "roboshop"
  }
}