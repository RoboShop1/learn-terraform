resource "aws_route" "transit-route" {
  for_each                  = toset(var.rts-ids)
  route_table_id            = each.value
  destination_cidr_block    = var.destation-cidr
  transit_gateway_id        = var.transit-gate-id
}

variable "rts-ids" {}
variable "destation-cidr" {}
variable "transit-gate-id" {}

