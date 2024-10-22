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

variable "key_list" {
  default = ["frontend","backend","database"]
}

variable "value_list" {
  default = ["nginx","nodejs","mysql"]
}

locals {
  zip_map = zipmap(var.key_list,var.value_list)
}

output "zip-map" {
  value = {for key, value  in  local.zip_map :  key => value if key == "database" }
}

