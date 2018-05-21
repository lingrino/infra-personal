output "vpc_id" {
  value = "${ aws_vpc.vpc.id }"
}

output "vpc_cidr" {
  value = "${ aws_vpc.vpc.cidr_block }"
}

output "vpc_cidr_ipv6" {
  value = "${ aws_vpc.vpc.ipv6_cidr_block }"
}

output "subnets_public_ids" {
  value = "${ aws_subnet.public.*.id }"
}

output "subnets_public_cidrs" {
  value = "${ aws_subnet.public.*.cidr_block }"
}

output "subnets_public_cidrs_ipv6" {
  value = "${ aws_subnet.public.*.ipv6_cidr_block }"
}

output "subnets_private_general_ids" {
  value = "${ aws_subnet.private_general.*.id }"
}

output "subnets_private_general_cidrs" {
  value = "${ aws_subnet.private_general.*.cidr_block }"
}

output "subnets_private_general_cidrs_ipv6" {
  value = "${ aws_subnet.private_general.*.ipv6_cidr_block }"
}

output "subnets_private_data_ids" {
  value = "${ aws_subnet.private_data.*.id }"
}

output "subnets_private_data_cidrs" {
  value = "${ aws_subnet.private_data.*.cidr_block }"
}

# output "subnets_private_data_cidrs_ipv6" {
#   value = "${ aws_subnet.private_data.*.ipv6_cidr_block }"
# }
