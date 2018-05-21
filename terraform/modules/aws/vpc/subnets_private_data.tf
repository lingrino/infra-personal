resource "aws_subnet" "private_data" {
  count = "${ length( var.subnets_private_data_azs_to_cidrs ) }"

  vpc_id = "${ aws_vpc.vpc.id }"

  availability_zone = "${ element( keys( var.subnets_private_data_azs_to_cidrs ), count.index ) }"
  cidr_block        = "${ element( values( var.subnets_private_data_azs_to_cidrs ), count.index ) }"
  ipv6_cidr_block   = "${ cidrsubnet( aws_vpc.vpc.ipv6_cidr_block, 8, count.index+60 ) }"

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = "${ merge(
    map(
      "Name",
      "${ var.name_prefix }_subnet_private_data_${ replace( element( keys( var.subnets_private_data_azs_to_cidrs ), count.index ), "-", "_" ) }"
    ),
    var.tags,
    module.constants.tags_default )
  }"
}

resource "aws_route_table_association" "private_data" {
  count = "${ length( var.subnets_private_data_azs_to_cidrs ) }"

  subnet_id      = "${ element( aws_subnet.private_data.*.id, count.index ) }"
  route_table_id = "${ element( aws_route_table.private_data.*.id, count.index ) }"
}
