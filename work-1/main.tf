variable "vpc" {
  default = {
    public = {
      public1 = { cidr_block = "10.0.1.0/24" ,  az = "us-east-1a" }
      public2 = { cidr_block = "10.0.2.0/24" ,  az = "us-east-1b" }
    }
    app = {
      app1 = { cidr_block = "10.0.3.0/24" ,  az = "us-east-1a" }
      app2 = { cidr_block = "10.0.4.0/24" ,  az = "us-east-1b" }
    }
  }
}

output "name" {
  value = { for i,j in var.vpc: i => j }
}