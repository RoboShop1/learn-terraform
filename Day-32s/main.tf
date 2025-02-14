module "vpc" {
  for_each          =  var.vpc
  source            = "./vpc"
  subnets           = each.value["subnets"]
  env               = each.key
  vpc_cidr_block    = each.value["vpc_cidr_block"]
}

resource "aws_ec2_transit_gateway" "example" {
  depends_on = [module.vpc]
  description = "dev-prod-tg"

  tags = {
    Name = "dev-prod-tg"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  for_each           = module.vpc
  subnet_ids         = values(each.value["app_subnets"])
  transit_gateway_id = aws_ec2_transit_gateway.example.id
  vpc_id             = each.value["vpc_id"]

  tags = {
    Name = "${each.key}-tg-attachment"
  }
}

module "tranist" {
  source = "./tranist"
  for_each = var.vpc

  rts-ids = flatten((values({ for i,j in lookup(module.vpc,each.key,null): i => values(j) if can(regex("rt",i)) })))
  destation-cidr = each.value["dest-cidr"]
  transit-gate-id = aws_ec2_transit_gateway.example.id
}


module "ec2" {
  for_each = var.vpc
  source = "./ec2"
  subnet_id = values(lookup(lookup(module.vpc, each.key,null),"public_subnets",null))[0]
}

variable "vpc" {
  default = {
    dev = {
      vpc_cidr_block = "10.0.0.0/16"
      dest-cidr      = "10.2.0.0/16"
      subnets        = {
        public = {
          public1 = {cidr_block = "10.0.1.0/24" , az = "us-east-1a"}
          public2 = {cidr_block = "10.0.2.0/24" , az = "us-east-1b"}
        }
        web = {
          web1 = {cidr_block = "10.0.3.0/24" , az = "us-east-1a"}
          web2 = {cidr_block = "10.0.4.0/24" , az = "us-east-1b"}
        }
        app = {
          app1 = {cidr_block = "10.0.5.0/24" , az = "us-east-1a"}
          app2 = {cidr_block = "10.0.6.0/24" , az = "us-east-1b"}
        }
        db = {
          db1 = {cidr_block = "10.0.7.0/24" , az = "us-east-1a"}
          db2 = {cidr_block = "10.0.8.0/24" , az = "us-east-1b"}
        }
      }
    }
    prod = {
      vpc_cidr_block = "10.2.0.0/16"
      dest-cidr      = "10.0.0.0/16"
      subnets        = {
        public = {
          public1 = {cidr_block = "10.2.1.0/24" , az = "us-east-1a"}
          public2 = {cidr_block = "10.2.2.0/24" , az = "us-east-1b"}
        }
        web = {
          web1 = {cidr_block = "10.2.3.0/24" , az = "us-east-1a"}
          web2 = {cidr_block = "10.2.4.0/24" , az = "us-east-1b"}
        }
        app = {
          app1 = {cidr_block = "10.2.5.0/24" , az = "us-east-1a"}
          app2 = {cidr_block = "10.2.6.0/24" , az = "us-east-1b"}
        }
        db = {
          db1 = {cidr_block = "10.2.7.0/24" , az = "us-east-1a"}
          db2 = {cidr_block = "10.2.8.0/24" , az = "us-east-1b"}
        }
      }
    }
  }
}

output "main" {
  value = module.vpc
}

# output "another" {
#   value = values(lookup(lookup(module.vpc, "dev",null),"app_subnets",null))
# }



output "dev_all_rts" {
  value = flatten((values({ for i,j in lookup(module.vpc,"dev",null): i => values(j) if can(regex("rt",i)) })))
}

output "prod_all_rts" {
  value = flatten(values({ for i,j in lookup(module.vpc,"prod",null): i => values(j) if can(regex("rt",i)) }))
}

# locals {
#   rts = values({ for i,j in lookup(module.vpc,"prod",null): i => values(j) if can(regex("rt",i)) })
#  }
#
# output "main1" {
#   value = concat([ for i in local.rts: i ])
# }