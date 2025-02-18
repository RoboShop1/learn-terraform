resource "aws_lb" "test" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = ["subnet-0071e36c53f811c0b","subnet-0354194ae815795f6"]

  tags = {
    Environment = "test-lb"
  }
}


resource "aws_lb_target_group" "test-target" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    interval = 10
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    path = "/index.html"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-target.arn
  }
}