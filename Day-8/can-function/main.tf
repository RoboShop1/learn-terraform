variable "name" {
  default = "chaitu"
}

output "main" {
  value = can(regex("linux|windows", var.name))
}