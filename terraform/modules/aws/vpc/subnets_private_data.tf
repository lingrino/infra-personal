resource "aws_subnet" "private_data" {
  count = "${ length( var.azs ) }"

  vpc_id = "${ aws_vpc.vpc.id }"

  availability_zone = "${ var.azs[count.index] }"
  cidr_block        = "${ cidrsubnet( aws_vpc.vpc.cidr_block, 6, count.index+16 ) }"

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_subnet_private_data_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags, module.constants.tags_default )
  }"
}

resource "aws_route_table_association" "private_data" {
  count = "${ length( var.azs ) }"

  subnet_id      = "${ element( aws_subnet.private_data.*.id, count.index ) }"
  route_table_id = "${ element( aws_route_table.private_data.*.id, count.index ) }"
}
