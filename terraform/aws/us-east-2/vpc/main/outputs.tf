output "vpc_id" {
  value = "${ module.vpc.vpc_id }"
}

output "vpc_cidr" {
  value = "${ module.vpc.vpc_cidr }"
}

output "vpc_cidr_ipv6" {
  value = "${ module.vpc.vpc_cidr_ipv6 }"
}

output "subnets_public_ids" {
  value = "${ module.vpc.subnets_public_ids }"
}

output "subnets_public_cidrs" {
  value = "${ module.vpc.subnets_public_cidrs }"
}

output "subnets_public_cidrs_ipv6" {
  value = "${ module.vpc.subnets_public_cidrs_ipv6 }"
}

output "subnets_private_general_ids" {
  value = "${ module.vpc.subnets_private_general_ids }"
}

output "subnets_private_general_cidrs" {
  value = "${ module.vpc.subnets_private_general_cidrs }"
}

output "subnets_private_general_cidrs_ipv6" {
  value = "${ module.vpc.subnets_private_general_cidrs_ipv6 }"
}

output "subnets_private_data_ids" {
  value = "${ module.vpc.subnets_private_data_ids }"
}

output "subnets_private_data_cidrs" {
  value = "${ module.vpc.subnets_private_data_cidrs }"
}
