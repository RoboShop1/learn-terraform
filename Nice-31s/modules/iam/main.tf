resource "aws_iam_user" "main" {
  name = var.name
  tags = var.tags
}


resource "aws_iam_user_policy" "lb_ro" {
  name = "${var.name}-ssm-policy"
  user = aws_iam_user.main.name
  policy = var.policy
}



variable "policy" {
  default = null
}
variable "name" {}
variable "tags" {}