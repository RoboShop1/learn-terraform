variable "networks" {
  default = {
    "private" = {
      cidr_block = "192.168.1.0/24"
      subnets    = {
        "sql1" = {
          cidr_block = "192.168.1.0/25"
        }
        "cosmos1" = {
          cidr_block = "192.168.1.128/25"
        }
      }
    },
    "public" = {
      cidr_block = "192.168.2.0/24"
      subnets    = {
        "app1" = {
          cidr_block = "192.168.2.0/28"
        }
        "app2" = {
          cidr_block = "192.168.2.16/28"
        }
      }
    }
  }
}


output "variables" {
  value = element([ for i,j in var.networks: j.subnets ],1)
}





#resource "aws_instance" "sample" {
#  for_each = var.names
#  ami           = "ami-0ddc798b3f1a5117e"
#  instance_type = "t2.micro"
#  availability_zone = "us-east-1a"
#
#
#
#  tags = {
#    Name = "demo-${each.key}"
#  }
#}
#
#output "values" {
#  value = aws_instance.sample
#}
#output "name" {
#  value = [for tags in aws_instance.sample: tags.tags]
#}
#
#output "ips" {
#  value = { for name, ip in aws_instance.sample: name => ip.public_ip if values(ip.tags) == "demo-name2" }
#}

// With list
#
#output "ips" {
#  value = aws_instance.sample[*].public_ip
#}
#
#output "ip-one" {
#  value = element(aws_instance.sample.*.public_ip,0)
#}
#
#output "ip" {
#  value = aws_instance.sample.*.public_ip[0]
#}
#
#output "tags" {
#  value = toset(values({
#    for i, j in aws_instance.sample: i => j.public_ip
#  }))
#}