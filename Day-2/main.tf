
variable "names" {
  default = {
    name1 = "name1"
    name2 = "name2"
  }
}
resource "aws_instance" "sample" {
  for_each = var.names
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"



  tags = {
    Name = "demo"
  }
}

output "ips" {
  value = { for name, ip in aws_instance.sample: name => ip.public_ip }
}

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