# output "subnets_ids" {
#   value = { for i,k in aws_subnet.main: i => k.id }
# }
#
# output "route_tables_ids" {
#   value = { for i,k in aws_route_table.main: i => k.id }
# }


output "subnet_ids" {
  value = aws_subnet.main
}

output "route_table_ids" {
  value = aws_route_table.main
}