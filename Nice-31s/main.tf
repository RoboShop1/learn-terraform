module "dev" {
  source = "./modules/ssm"
  inputs = var.dev-values
  env    = "dev"
  access = "chaitu-dev"
}


module "dev-iam" {
  source = "./modules/iam"
  name   = "chaitu"
  tags   = {
    Name   = "chaitu"
    access = "chaitu-dev"
  }
}




module "prod" {
  source = "./modules/ssm"
  inputs = var.prod-values
  env    = "prod"
  access = "renuka-prod"
}

module "prod-iam" {
  source = "./modules/iam"
  name   = "renuka"
  policy = var.r-policy
  tags   = {
    Name   = "renuka"
    access = "renuka-prod"
  }
}


variable "r-policy" {
  default = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeParameters",
                "ssm:GetParameterHistory",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}







variable "dev-values" {
  default = {
    chaitu1 = "chaitu1"
    chaitu2 = "chaitu2"
    chaitu3 = "chaitu3"
  }
}

variable "prod-values" {
  default = {
    r1 = "r1"
    r2 = "r2"
    r3 = "r3"
  }
}