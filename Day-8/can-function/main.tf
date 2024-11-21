variable "name" {
  default = "chaitu is good boy"
}

output "main" {
  value = strcontains(var.name, "main")
}