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

data "aws_ec2_instance_type_offerings" "example" {
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  location_type = "availability-zone"
}

