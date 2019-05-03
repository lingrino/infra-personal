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

output "subnets_private_ids" {
  value = "${ aws_subnet.private.*.id }"
}

output "subnets_private_cidrs" {
  value = "${ aws_subnet.private.*.cidr_block }"
}

output "subnets_private_cidrs_ipv6" {
  value = "${ aws_subnet.private.*.ipv6_cidr_block }"
}

output "subnets_intra_ids" {
  value = "${ aws_subnet.intra.*.id }"
}

output "subnets_intra_cidrs" {
  value = "${ aws_subnet.intra.*.cidr_block }"
}
