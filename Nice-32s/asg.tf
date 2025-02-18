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