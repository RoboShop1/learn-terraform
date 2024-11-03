locals {
  name = jsonencode({
    Name  = "chaitu",
    Name1 = {
      one = "one",
      two = "two"
    }
  })
}

output "main" {
  value = { for i,k in jsondecode(local.name): i => k }
}
