variable "name" {
  default = "linux"
}

output "main" {
  value = can(regex("linux|windows", var.name))
}