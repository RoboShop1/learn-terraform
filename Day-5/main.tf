module "vpc" {
  source = "./vpc"
  env    = "dev"
  vpc_cidr = "10.0.0.0/16"
  availability_zone = ["us-east-1a","us-east-1b","us-east-1c"]
  public_subnets_cidr = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}


locals {
  subnets = {
    for value in module.vpc.subnets: value.availability_zone => value.id
  }
}

#output "subnet" {
#  value = module.vpc.subnets
#}

output "rt" {
  value = module.vpc.rt
}

#output "j" {
#  value = <<EOT
#%{ for rt in module.vpc.rt }
#%{ if rt.tags.Name == "public-rt2" }${rt.id}%{ endif }
#%{ endfor }
#EOT
#}

output "j" {
  value = module.vpc.k
}


resource "aws_instance" "main" {
  for_each = local.subnets
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  subnet_id = each.value
  key_name = "nvirginia"
  associate_public_ip_address = true

  tags = {
    Name = each.key
  }
}