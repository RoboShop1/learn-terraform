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

/* // zip-map //
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
*/

// senstive

#variable "name" {
#  default = "chaithanya"
#  sensitive = true
#}
#
#output "name" {
#  value = var.name
#  sensitive = true
#}

// provisioners

resource "null_resource" "c" {

    connection {
      type     = "ssh"
      user     = "ec2-user"
      password = "DevOps321"
      host     = "54.161.8.6"
    }



  provisioner "file" {
    source      = templatefile("${path.module}/hello.txt",{
      name = "chaitu"
    })
    destination = "/tmp/hello1.txt"
  }
}


























