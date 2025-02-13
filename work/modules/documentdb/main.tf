resource "null_resource" "main" {
  triggers = {
    Name = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "echo this is ==documentdb===="
  }
}

