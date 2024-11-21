variable "name" {
  default = "linux"
}

#output "main" {
#  value = can(startswith("hello world", "main"))
#}

output "main" {
  value = can(tostring(false))
}