resource "aws_vpn_gateway" "vpn" {
  count = var.create_vpn_gateway ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_vpn_gateway" },
    var.tags
  )
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count = var.create_vpn_gateway ? 1 : 0

  route_table_id = aws_route_table.public.id
  vpn_gateway_id = aws_vpn_gateway.vpn.0.id
}

resource "aws_vpn_gateway_route_propagation" "private" {
  for_each = var.create_vpn_gateway ? toset(aws_route_table.private) : {}

  route_table_id = each.value.id
  vpn_gateway_id = aws_vpn_gateway.vpn.0.id
}

resource "aws_vpn_gateway_route_propagation" "intra" {
  for_each = var.create_vpn_gateway ? toset(aws_route_table.intra) : {}

  route_table_id = each.value.id
  vpn_gateway_id = aws_vpn_gateway.vpn.0.id
}
