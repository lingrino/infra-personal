output "azs" {
  value = keys(var.azs)
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "vpc_cidr_ipv6" {
  value = aws_vpc.vpc.ipv6_cidr_block
}

output "nat_ids" {
  value = [for nat in aws_nat_gateway.nat : nat.id]
}

output "subnet_ids" {
  value = concat(
    [for sn in aws_subnet.public : sn.id],
    [for sn in aws_subnet.private : sn.id],
    [for sn in aws_subnet.intra : sn.id],
  )
}

output "subnet_cidrs" {
  value = concat(
    [for sn in aws_subnet.public : sn.cidr_block],
    [for sn in aws_subnet.private : sn.cidr_block],
    [for sn in aws_subnet.intra : sn.cidr_block],
  )
}

output "subnet_cidrs_ipv6" {
  value = concat(
    [for sn in aws_subnet.public : sn.ipv6_cidr_block],
    [for sn in aws_subnet.private : sn.ipv6_cidr_block],
    [for sn in aws_subnet.intra : sn.ipv6_cidr_block],
  )
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

output "route_table_ids" {
  value = concat(
    [aws_route_table.public.id],
    [for rt in aws_route_table.private : rt.id],
    [for rt in aws_route_table.intra : rt.id],
  )
}

output "route_tables_public_ids" {
  value = [aws_route_table.public.id]
}

output "route_tables_private_ids" {
  value = [for rt in aws_route_table.private : rt.id]
}

output "route_tables_intra_ids" {
  value = [for rt in aws_route_table.intra : rt.id]
}
