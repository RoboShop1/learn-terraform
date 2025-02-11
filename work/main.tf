variable "demo" {
  default = {

        public1 = "nat-04dea6bfa489764e7"
        public2 = "nat-038fb17eac53b3f58"
      }
}

variable "web" {
  default = {
    web1 = "web1"
    web2 = "web2"
  }
}


output "name" {
  value = try(var.demo.public4,"lllll")
}

output "ll" {
  value = can(regex(1,"chaitu1c"))
}