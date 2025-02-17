resource "aws_launch_template" "main" {
  name          = "sample"
  image_id      = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"

  placement {
    availability_zone = "us-east-1b"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "sample"
    }
  }
}