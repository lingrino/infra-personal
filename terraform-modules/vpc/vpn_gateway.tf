resource "aws_vpn_gateway" "vpn" {
  count  = "${ var.create_vpn_gateway ? 1 : 0 }"
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_vpn_gateway" ),
    var.tags, module.constants.tags_default )
  }"
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count          = "${ var.create_vpn_gateway ? 1 : 0}"
  route_table_id = "${ aws_route_table.public.id }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}

resource "aws_vpn_gateway_route_propagation" "private_general" {
  count          = "${ var.create_vpn_gateway ? length( var.azs ) : 0 }"
  route_table_id = "${ element( aws_route_table.private_general.*.id, count.index ) }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}

resource "aws_vpn_gateway_route_propagation" "private_data" {
  count          = "${ var.create_vpn_gateway ? length( var.azs ) : 0 }"
  route_table_id = "${ element( aws_route_table.private_data.*.id, count.index ) }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}
