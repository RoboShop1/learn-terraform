module "vpc" {
  source     = "./vpc"
  for_each   = var.vpc
  env        = each.key
  vpc_cidr   = each.value["cidr"]
}



variable "vpc" {}
vpc = {
  dev = {
    cidr = "10.0.0.0/0"
    subnets = {
      public = {
        public1 = { cidr = "10.0.1.0/24" ,az = "us-east-1a" }
        public2 = { cidr = "10.0.2.0/24", az = "us-east-1b" }
      }
      web = {
        web1 = { cidr = "10.0.3.0/24" ,az = "us-east-1a" }
        web2 = { cidr = "10.0.4.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.5.0/24" ,az = "us-east-1a" }
        app2 = { cidr = "10.0.6.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.7.0/24" ,az = "us-east-1a" }
        db2 = { cidr = "10.0.8.0/24", az = "us-east-1b" }
      }
    }
  }
}