variable "name" {
  default = "chaitu is good boy"
}

output "main" {
  value = can(strcontains("hello world", "boy"))
}