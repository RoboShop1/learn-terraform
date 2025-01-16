data "aws_nat_gateways" "ngws" {
  vpc_id = "vpc-0e1d7927c4e1fa1e4"

  filter {
    name   = "state"
    values = ["available"]
  }
}

# data "aws_nat_gateway" "ngw" {
#   count = length(data.aws_nat_gateways.ngws.ids)
#   id    = tolist(data.aws_nat_gateways.ngws.ids)[count.index]
# }

output "sample" {
  value = data.aws_nat_gateways.ngws
}