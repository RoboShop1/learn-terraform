variable "vpc" {
  default = {
    public = {
      public1 = { cidr_block = "10.0.1.0/24" ,  az = "us-east-1a" }
      public2 = { cidr_block = "10.0.2.0/24" ,  az = "us-east-1b" }
    }
    app = {
      app1 = { cidr_block = "10.0.3.0/24" ,  az = "us-east-1a" }
      app2 = { cidr_block = "10.0.4.0/24" ,  az = "us-east-1b" }
    }
  }
}

variable "name" {
  type = map(object({
    public1 = map(string)
    public2 = map(string)
  }))

  default = {
    public = {
      public1 = { cidr_block = "10.0.1.0/24" ,  az = "us-east-1a" }
      public2 = { cidr_block = "10.0.2.0/24" ,  az = "us-east-1b" }
    }
    app = {
      public1 = { cidr_block = "10.0.1.0/24" ,  az = "us-east-1a" }
      public2 = { cidr_block = "10.0.2.0/24" ,  az = "us-east-1b" }
    }

  }
}

# output "all" {
#   value = var.name
# }




variable "one1" {
  type = list(object({
    one = string
    two = string
  }))

  default = [

    {one = "one", two = "two"},
    {one = "one", two = "two"}

  ]

}

# output "one1" {
#   value = var.one1
# }






variable "all" {
  type = string
  default = "one"
}

variable "list1" {
  type = list(number)
  default = [1,2,4,5]
}

variable "map1" {
  type = map(number)

  default = {
    one1 = 1
    two  = 2
  }

}

# output "map1" {
#   value = var.map1
# }





variable "top" {
  type = object({
    name = map(string)
    number = list(number)
    top    = bool
  })

  default = {
    name = { one = "one" , two = "two"}
    number = [1,2,4,6]
    top   = true
  }
}

output "lop" {
  value = var.top
}







