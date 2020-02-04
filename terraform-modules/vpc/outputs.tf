output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_cidr_ipv6" {
  value = aws_vpc.vpc.ipv6_cidr_block
}

output "subnets_public_ids" {
  value = [for sn in aws_subnet.public : sn.id]
}

output "subnets_public_cidrs" {
  value = [for sn in aws_subnet.public : sn.cidr_block]
}

output "subnets_public_cidrs_ipv6" {
  value = [for sn in aws_subnet.public : sn.ipv6_cidr_block]
}

output "subnets_private_ids" {
  value = [for sn in aws_subnet.private : sn.id]
}

output "subnets_private_cidrs" {
  value = [for sn in aws_subnet.private : sn.cidr_block]
}

output "subnets_private_cidrs_ipv6" {
  value = [for sn in aws_subnet.private : sn.ipv6_cidr_block]
}

output "subnets_intra_ids" {
  value = [for sn in aws_subnet.intra : sn.id]
}

output "subnets_intra_cidrs" {
  value = [for sn in aws_subnet.intra : sn.cidr_block]
}
