resource "aws_instance" "sample" {
  count = 2
  ami           = "ami-0ddc798b3f1a5117e"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "demo-${count.index}"
  }
}

// With list

output "ips" {
  value = aws_instance.sample[*].public_ip
}

output "ip-one" {
  value = element(aws_instance.sample.*.public_ip,0)
}

output "ip" {
  value = aws_instance.sample.*.public_ip[0]
}

output "tags" {
  value = toset(aws_instance.sample.*.tags)
}