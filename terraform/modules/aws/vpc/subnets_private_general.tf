resource "aws_subnet" "private_general" {
  count = "${ length( var.azs ) }"

  vpc_id = "${ aws_vpc.vpc.id }"

  availability_zone = "${ var.azs[count.index] }"
  cidr_block        = "${ cidrsubnet( aws_vpc.vpc.cidr_block, 6, count.index+8 ) }"
  ipv6_cidr_block   = "${ cidrsubnet( aws_vpc.vpc.ipv6_cidr_block, 8, count.index+8 ) }"

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = "${ merge(
    map(
      "Name",
      "${ var.name_prefix }_subnet_private_general_${ replace( var.azs[count.index], "-", "_" ) }"
    ),
    var.tags,
    module.constants.tags_default )
  }"
}

resource "aws_route_table_association" "private_general" {
  count = "${ length( var.azs ) }"

  subnet_id      = "${ element( aws_subnet.private_general.*.id, count.index ) }"
  route_table_id = "${ element( aws_route_table.private_general.*.id, count.index ) }"
}
