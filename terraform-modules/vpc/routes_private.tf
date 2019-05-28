resource "aws_route_table" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_route_table_private_${replace(var.azs[count.index], "-", "_")}" },
    var.tags
  )
}

resource "aws_route" "nat" {
  count = var.create_nat_gateways ? length(var.azs) : 0

  route_table_id         = aws_route_table.private.*.id[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.*.id[count.index]
}

resource "aws_route" "private_eoigw" {
  count = length(var.azs)

  route_table_id              = aws_route_table.private.*.id[count.index]
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.igw.id
}
