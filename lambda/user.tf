resource "aws_iam_user" "lb" {
  name = "invoke"

  tags = {
    Name = "invoke"
  }
}

resource "aws_iam_access_key" "my_user_key" {
  user = aws_iam_user.lb.name
}

# Output Access Key (Visible in Console)
output "access_key_id" {
  value = aws_iam_access_key.my_user_key.id
}

# Output Secret Key (Sensitive - Hidden in Console)
output "secret_access_key" {
  value = aws_iam_access_key.my_user_key.encrypted_secret
}
