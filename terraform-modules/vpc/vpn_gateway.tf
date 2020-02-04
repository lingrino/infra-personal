resource "aws_vpn_gateway" "vpn" {
  count = var.create_vpn_gateway ? 1 : 0

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_vpn_gateway" },
    var.tags
  )
}

resource "aws_vpn_gateway_route_propagation" "rp" {
  for_each = var.create_vpn_gateway ? {
    for i in range(length(local.route_tables)) :
    i => {
      rt    = local.route_tables[i]
      vpngw = aws_vpn_gateway.vpn[0]
    }
  } : {}

  route_table_id = each.value.rt.id
  vpn_gateway_id = each.value.vpngw.id
}
