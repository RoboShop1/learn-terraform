provider "aws" {
  region = "us-east-1"
}

variable "instances" {
  default = ["web","app","db"]
}

variable "names" {
  default = ["chaitu1","chaitu2","chaitu3"]
}


output "contact" {
  value = concat(var.instances,var.names)
}

output "faltten" {
  value = flatten([var.instances,var.names])
}

# resource "aws_instance" "main" {
#   count = length(var.instances)
#   ami = "ami-01816d07b1128cd2d"
#   instance_type = "t2.micro"
#
#   tags = {
#     Name = var.instances[count.index]
#   }
# }

# output "of_list" {
#   value = element(aws_instance.main[*].id,0)
# }


# output "of_list" {
#   value = aws_instance.main.*.id[0]
# }

# List of map .*. we can use 0
# list of map [*] we can user element(, 0)


