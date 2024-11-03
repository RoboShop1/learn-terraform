data "aws_availability_zones" "zones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

#output "zones" {
#  value = data.aws_availability_zones.zones.names
#}

data "aws_ec2_instance_type_offerings" "example" {
  for_each = toset(data.aws_availability_zones.zones.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }

  filter {
    name   = "location"
    values = [each.value]
  }

  location_type = "availability-zone-id"
}

output "instance_types" {
  value = keys(data.aws_ec2_instance_type_offerings.example)
}

