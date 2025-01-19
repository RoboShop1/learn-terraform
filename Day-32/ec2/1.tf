"app" = {
  "subnets" = {
    "app1" = {
      "arn"                                            = "arn:aws:ec2:us-east-1:339712959230:subnet/subnet-04254f4d8dceac3a2"
      "assign_ipv6_address_on_creation"                = false
      "availability_zone"                              = "us-east-1a"
      "availability_zone_id"                           = "use1-az2"
      "cidr_block"                                     = "10.0.5.0/24"
      "customer_owned_ipv4_pool"                       = ""
      "enable_dns64"                                   = false
      "enable_lni_at_device_index"                     = 0
      "enable_resource_name_dns_a_record_on_launch"    = false
      "enable_resource_name_dns_aaaa_record_on_launch" = false
      "id"                                             = "subnet-04254f4d8dceac3a2"
      "ipv6_cidr_block"                                = ""
      "ipv6_cidr_block_association_id"                 = ""
      "ipv6_native"                                    = false
      "map_customer_owned_ip_on_launch"                = false
      "map_public_ip_on_launch"                        = false
      "outpost_arn"                                    = ""
      "owner_id"                                       = "339712959230"
      "private_dns_hostname_type_on_launch"            = "ip-name"
      "tags" = tomap({
        "Name" = "dev-app1-subnet"
      })
      "tags_all" = tomap({
        "Name" = "dev-app1-subnet"
      })
      "timeouts" = null /* object */
      "vpc_id" = "vpc-08fa99fd8f090da50"
    }
    "app2" = {
      "arn"                                            = "arn:aws:ec2:us-east-1:339712959230:subnet/subnet-003ab426e4ade25da"
      "assign_ipv6_address_on_creation"                = false
      "availability_zone"                              = "us-east-1b"
      "availability_zone_id"                           = "use1-az4"
      "cidr_block"                                     = "10.0.6.0/24"
      "customer_owned_ipv4_pool"                       = ""
      "enable_dns64"                                   = false
      "enable_lni_at_device_index"                     = 0
      "enable_resource_name_dns_a_record_on_launch"    = false
      "enable_resource_name_dns_aaaa_record_on_launch" = false
      "id"                                             = "subnet-003ab426e4ade25da"
      "ipv6_cidr_block"                                = ""
      "ipv6_cidr_block_association_id"                 = ""
      "ipv6_native"                                    = false
      "map_customer_owned_ip_on_launch"                = false
      "map_public_ip_on_launch"                        = false
      "outpost_arn"                                    = ""
      "owner_id"                                       = "339712959230"
      "private_dns_hostname_type_on_launch"            = "ip-name"
      "tags" = tomap({
        "Name" = "dev-app2-subnet"
      })
      "tags_all" = tomap({
        "Name" = "dev-app2-subnet"
      })
      "timeouts" = null /* object */
      "vpc_id" = "vpc-08fa99fd8f090da50"
    }
  }
}