variable "name" {
  default = "linux"
}

output "main" {
  value = can(startswith("hello world", "main"))
}