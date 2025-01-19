
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-gw"
  }
}

module "subnets" {
  for_each = var.subnets
  source = "./subnets"
  vpc_id = aws_vpc.main.id
  subnets = each.value
  env     = var.env
}


resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.gw]
  for_each   = lookup(var.subnets,"public",null)
  domain     = "vpc"
}


resource "aws_nat_gateway" "main" {
  for_each      = lookup(var.subnets,"public",null)

  allocation_id = lookup(lookup(aws_eip.eip,each.key,null),"id",null)
  subnet_id     = lookup(lookup(lookup(lookup(module.subnets,"public",null),"subnet_ids",null),each.key,"null"),"id",null)

  tags = {
    Name = "${var.env}-vpc-${each.key}-nat"
  }
  depends_on = [aws_internet_gateway.gw]
}


output "nats" {
  value = aws_nat_gateway.main
}

 resource "aws_route" "main" {

  for_each                  = toset(keys(merge(var.subnets["web"],var.subnets["app"],var.subnets["db"])))
  route_table_id            = lookup(local.rt_ids,each.key,null)
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = strcontains(each.key, "1") ? lookup(aws_nat_gateway.main,"public1",null)["id"] : lookup(aws_nat_gateway.main,"public2",null)["id"]
}


output "done" {
  value = lookup(aws_nat_gateway.main,"public1",null)["id"]
}

# output "subnets" {
#   value = {for m,n in { for i,k in module.subnets:  i => k.subnet_ids if i != "public" }: m => n  }
# }

output "app" {
  value = { for i,k in lookup(lookup(module.subnets,"app",null),"subnet_ids",null): i => k.id }
}

locals {
  app_subnets = { for i,k in lookup(lookup(module.subnets,"app",null),"subnet_ids",null): i => k.id }
  web_subnets = { for i,k in lookup(lookup(module.subnets,"web",null),"subnet_ids",null): i => k.id }
  db_subnets  = { for i,k in lookup(lookup(module.subnets,"db",null),"subnet_ids",null): i => k.id }

  s_ids        =  merge(local.app_subnets,local.web_subnets,local.db_subnets)

  app_rt_ids = { for i,k in lookup(lookup(module.subnets,"app",null),"route_table_ids",null): i => k.id }
  web_rt_ids = { for i,k in lookup(lookup(module.subnets,"web",null),"route_table_ids",null): i => k.id }
  db_rt_ids  = { for i,k in lookup(lookup(module.subnets,"db",null),"route_table_ids",null): i => k.id }
  rt_ids     =  merge(local.db_rt_ids,local.app_rt_ids,local.web_rt_ids)

}


output "ids" {
  value = merge(local.app_subnets,local.web_subnets,local.db_subnets)
}

output "rts" {
  value = merge(local.db_rt_ids,local.app_rt_ids,local.web_rt_ids)
}
# output "one" {
#   value = merge(local.app_rt_ids,local.db_rt_ids,,local.web_rt_ids)
# }

# output "eip" {
#   value = aws_eip.eip
# }



# resource "null_resource" "one" {
#   for_each = aws_eip.eip
#   provisioner "local-exec" {
#     command = "echo eip - ${each.value["id"]}"
#   }
# }



variable "vpc_cidr" {}
variable "env" {}
variable "subnets" {}

#
# output "out_sub" {
#   value = module.subnets
# }


# output "public_subnets_ids" {
#   value = { for i,k in lookup(lookup(module.subnets,"public",null),"subnet_ids",null): i=>k.id}
# }
# output "sample1" {
#   value = { for i,k in  module.subnets: i=> k.subnets_ids if i == "public"}
# }

# output "sample" {
#   value = flatten([ for i,k in  module.subnets:  values(k.subnets_ids)  ])
# }


# output "out_sub" {
#   value ={for i,k in module.subnets:  i => values(k.subnets).*.id  }
# }