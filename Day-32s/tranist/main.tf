resource "aws_route" "transit-route" {
  for_each                  = var.dev-routes
  route_table_id            = each.value
  destination_cidr_block    = var.dev-destation-cidr
  transit_gateway_id        = var.transit-gate-id
}

