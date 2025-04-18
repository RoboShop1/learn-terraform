variable "vpc" {
  default = {
    dev = {
      vpc_cidr_block = "10.0.0.0/16"
      subnets = {
        public = {
          public1 = {cidr_block = "10.0.1.0/24", az = "us-east-1a"}
          public2 = { cidr_block = "10.0.2.0/24", az = "us-east-1b" }
        }
        web    = {
          web1 = {cidr_block = "10.0.3.0/24", az = "us-east-1a"}
          web2 = { cidr_block = "10.0.4.0/24", az = "us-east-1b" }
        }
        app    = {
          app1 = {cidr_block = "10.0.5.0/24", az = "us-east-1a"}
          app2 = {cidr_block = "10.0.6.0/24", az = "us-east-1a"}
        }

        db     = {
          db1 = {cidr_block = "10.0.7.0/24", az = "us-east-1a"}
          db2 = {cidr_block = "10.0.8.0/24", az = "us-east-1a"}
        }
      }
    }
  }
}
