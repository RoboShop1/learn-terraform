data "aws_availability_zones" "zones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

#output "zones" {
#  value = data.aws_availability_zones.zones.names
#}

#data "aws_ec2_instance_type_offerings" "example" {
#  for_each = toset(data.aws_availability_zones.zones.names)
#
#  filter {
#    name   = "instance-type"
#    values = ["t3,micro"]
#  }
#
#  filter {
#    name   = "location"
#    values = ["${each.value}"]
#  }
#
#  location_type = "availability-zone"
#}
#
#output "instance_types" {
#  value = data.aws_ec2_instance_type_offerings.example
#}
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each=toset(data.aws_availability_zones.zones.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}



output "output_v3_1" {
  value = { for az, details in data.aws_ec2_instance_type_offerings.my_ins_type :
    az => details.instance_types }
}
#resource "aws_instance" "sample" {
#  ami           = "ami-06b21ccaeff8cd686"
#  instance_type = "t3.micro"
#  availability_zone = "us-east-1e"
#}