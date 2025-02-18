
/*
resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a","us-east-1b"]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "Sample-ASG"
  }
}
*/



resource "aws_instance" "main" {
  ami = "ami-0b4f379183e5706b9"

  instance_type = "t3.small"

  root_block_device {
    volume_size = 20
    encrypted = true
    kms_key_id = data.aws_kms_key.main.id

  }

  tags = {
    Name = "demo-encrypt"
  }

}

data "aws_kms_key" "main" {
  key_id = "alias/my-secret-key"
}

output "all" {
  value = data.aws_kms_key.main
}