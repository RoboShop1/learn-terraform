module "dev-vpc" {
  source               = "./vpc"
  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["us-east-1a","us-east-1b"]
  public_cidr_blocks   = ["10.0.1.0/24","10.0.2.0/24"]
  private_cidr_blocks  = ["10.0.3.0/24","10.0.4.0/24"]
  db_cidr_blocks       = ["10.0.5.0/24","10.0.6.0/24"]
}

variable "istio-install" {}

module "eks" {
  depends_on = [module.dev-vpc]

  source = "./eks"
  vpc_id = module.dev-vpc.vpc_id
  public_subnets = module.dev-vpc.public_subnets
  private_subnets = module.dev-vpc.private_subnets
}

#
# module "iam-access" {
#   source = "./iam-access-entry"
#   cluster_name = module.eks.cluster_name
# }


output "id" {
  value = module.eks
}

output "replace" {
  value = replace(module.eks.id,"https://","")
}

output "split" {
  value = split("/",module.eks.id)[4]
}