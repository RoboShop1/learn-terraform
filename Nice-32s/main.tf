resource "aws_launch_template" "main" {
  name          = "sample"
  image_id      = "ami-0b4f379183e5706b9"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0665a56c7cd09a0e0"]

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 5
    }
  }

  placement {
    availability_zone = "us-east-1b"
  }
  tags = {
    Name = "sample"
  }
  dynamic "tag_specifications" {
    for_each = var.tag_specifications
    iterator = tag
    content {
      resource_type = tag.key

      tags = {
        Name = tag.value
      }

    }
  }

}

variable "tag_specifications" {
  default = {
    instance = "sample-instance"
    volume   = "sample-volume"
    network-interface = "sample-network"
  }
}