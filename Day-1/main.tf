/*  // for_each loop with list using toset //
variable "list" {
  default = ["one","two","three","four"]
}

resource "null_resource" "first" {
  for_each = toset(var.list)
  provisioner "local-exec" {
    command = "echo This is - ${base64encode("${each.key}")} and - ${each.value}"
    # command = "echo This is - ${base64encode(each.key)} and - ${each.value}"
  }
}
*/

locals {
  json = jsonencode(
    {
      zip       = "zap",
      foo       = "bar"
    }
  )
}

output "json1" {
  value = jsondecode(local.json).zip
}
