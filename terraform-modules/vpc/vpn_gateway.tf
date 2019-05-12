resource "aws_vpn_gateway" "vpn" {
  count = var.create_vpn_gateway ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {"Name" = "${var.name_prefix}_vpn_gateway"},
    var.tags
  )
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count = var.create_vpn_gateway ? 1 : 0

  route_table_id = aws_route_table.public.id
  vpn_gateway_id = aws_vpn_gateway.vpn[0].id
}

resource "aws_vpn_gateway_route_propagation" "private" {
  count = var.create_vpn_gateway ? length(var.azs) : 0

  route_table_id = aws_route_table.private.*.id[count.index]
  vpn_gateway_id = aws_vpn_gateway.vpn[0].id
}

resource "aws_vpn_gateway_route_propagation" "intra" {
  count = var.create_vpn_gateway ? length(var.azs) : 0

  route_table_id = aws_route_table.intra.*.id[count.index]
  vpn_gateway_id = aws_vpn_gateway.vpn[0].id
}
