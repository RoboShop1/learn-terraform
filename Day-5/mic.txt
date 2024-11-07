web = [
  {
    "arn" = "arn:aws:ec2:us-east-1:339712959230:subnet/subnet-005a63b13ff7820bb"
    "assign_ipv6_address_on_creation" = false
    "availability_zone" = "us-east-1a"
    "availability_zone_id" = "use1-az2"
    "cidr_block" = "10.0.3.0/24"
    "customer_owned_ipv4_pool" = ""
    "enable_dns64" = false
    "enable_lni_at_device_index" = 0
    "enable_resource_name_dns_a_record_on_launch" = false
    "enable_resource_name_dns_aaaa_record_on_launch" = false
    "id" = "subnet-005a63b13ff7820bb"
    "ipv6_cidr_block" = ""
    "ipv6_cidr_block_association_id" = ""
    "ipv6_native" = false
    "map_customer_owned_ip_on_launch" = false
    "map_public_ip_on_launch" = false
    "outpost_arn" = ""
    "owner_id" = "339712959230"
    "private_dns_hostname_type_on_launch" = "ip-name"
    "tags" = tomap({
      "Name" = "web-subnet1-us-east-1a-10.0.3.0/24"
      "project" = "Roboshop"
    })
    "tags_all" = tomap({
      "Name" = "web-subnet1-us-east-1a-10.0.3.0/24"
      "project" = "Roboshop"
    })
    "timeouts" = null /* object */
    "vpc_id" = "vpc-0ad5d4d63a096236c"
  },
  {
    "arn" = "arn:aws:ec2:us-east-1:339712959230:subnet/subnet-0efad49c94c29b4d4"
    "assign_ipv6_address_on_creation" = false
    "availability_zone" = "us-east-1b"
    "availability_zone_id" = "use1-az4"
    "cidr_block" = "10.0.4.0/24"
    "customer_owned_ipv4_pool" = ""
    "enable_dns64" = false
    "enable_lni_at_device_index" = 0
    "enable_resource_name_dns_a_record_on_launch" = false
    "enable_resource_name_dns_aaaa_record_on_launch" = false
    "id" = "subnet-0efad49c94c29b4d4"
    "ipv6_cidr_block" = ""
    "ipv6_cidr_block_association_id" = ""
    "ipv6_native" = false
    "map_customer_owned_ip_on_launch" = false
    "map_public_ip_on_launch" = false
    "outpost_arn" = ""
    "owner_id" = "339712959230"
    "private_dns_hostname_type_on_launch" = "ip-name"
    "tags" = tomap({
      "Name" = "web-subnet2-us-east-1b-10.0.4.0/24"
      "project" = "Roboshop"
    })
    "tags_all" = tomap({
      "Name" = "web-subnet2-us-east-1b-10.0.4.0/24"
      "project" = "Roboshop"
    })
    "timeouts" = null /* object */
    "vpc_id" = "vpc-0ad5d4d63a096236c"
  },
]
