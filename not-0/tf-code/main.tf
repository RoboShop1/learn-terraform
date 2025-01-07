# resource "aws_iam_openid_connect_provider" "aws-eks" {
#   url = "https://oidc.eks.us-east-1.amazonaws.com/id/72C33B2DB839B43409342129B8552393"
#
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#
#   thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
# }



resource "aws_iam_role" "test_role" {
  name = "aws_irsa_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Federated": "arn:aws:iam::339712959230:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/72C33B2DB839B43409342129B8552393"
        },
        "Action": "sts:AssumeRoleWithWebIdentity",
        "Condition": {
          "StringEquals": {
            "oidc.eks.us-east-1.amazonaws.com/id/72C33B2DB839B43409342129B8552393:sub": "system:serviceaccount:default:irsa-sa"
          }
        }
      }
    ]
  })

  tags = {
    tag-key = "aws_irsa_role"
  }
}


resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}