variable "name" {
  default = "linux"
}

output "main" {
  value = startswith("hello world", "main")
}