resource "aws_vpn_gateway" "vpn" {
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map(
      "Name",
      "${ var.name_prefix }_vpn_gateway"
    ),
    var.tags,
    module.constants.tags_default )
  }"
}

resource "aws_vpn_gateway_route_propagation" "public" {
  route_table_id = "${ aws_route_table.public.id }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}

resource "aws_vpn_gateway_route_propagation" "private_general" {
  count = "${ length( var.subnets_private_general_azs_to_cidrs ) }"

  route_table_id = "${ element( aws_route_table.private_general.*.id, count.index ) }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}

resource "aws_vpn_gateway_route_propagation" "private_data" {
  count = "${ length( var.subnets_private_data_azs_to_cidrs ) }"

  route_table_id = "${ element( aws_route_table.private_data.*.id, count.index ) }"
  vpn_gateway_id = "${ aws_vpn_gateway.vpn.id }"
}
