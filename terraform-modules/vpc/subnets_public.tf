resource "aws_subnet" "public" {
  count = "${ length( var.azs ) }"

  vpc_id = "${ aws_vpc.vpc.id }"

  availability_zone = "${ var.azs[count.index] }"
  cidr_block        = "${ cidrsubnet( aws_vpc.vpc.cidr_block, 6, count.index ) }"
  ipv6_cidr_block   = "${ cidrsubnet( aws_vpc.vpc.ipv6_cidr_block, 8, count.index ) }"

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_subnet_public_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags
  )}"
}

resource "aws_route_table_association" "public" {
  count = "${ length( var.azs ) }"

  subnet_id      = "${ element( aws_subnet.public.*.id, count.index ) }"
  route_table_id = "${ aws_route_table.public.id }"
}
