module "vpc" {
  source             = "./modules/vpc"
  env                = "dev"
  vpc_cidr_block     = "10.0.0.0/16"
  public_cidr_blocks = ["10.0.1.0/24","10.0.2.0/24"]
  availability_zones = ["us-east-1a","us-east-1b"]
}

module "ec2" {
  count  = 2
  source = "./modules/ec2"
  ami    = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  vpc_id = module.vpc.vpc_id
  subnet_id = element(module.vpc.public_subnets_ids,count.index)
}

output "main_subnets" {
  value = module.vpc.public_sample
}