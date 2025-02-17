resource "aws_launch_template" "main" {
  name          = "sample"
  image_id      = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0665a56c7cd09a0e0"]

  placement {
    availability_zone = "us-east-1b"
  }

  tags = {
    Name = "sample"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "sample"
    }
  }
}