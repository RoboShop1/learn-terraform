#data "aws_availability_zones" "example" {
#  filter {
#    name   = "opt-in-status"
#    values = ["opt-in-not-required"]
#  }
#}
#
#output "zones" {
#  value = data.aws_availability_zones.example.names
#}

data "aws_ec2_instance_type_offering" "example" {
  filter {
    name   = "instance-type"
    values = ["t2.micro", "t3.micro"]
  }
}

output "name" {
  value = data.aws_ec2_instance_type_offering.example.instance_type
}