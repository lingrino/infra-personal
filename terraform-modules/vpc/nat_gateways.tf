resource "aws_eip" "eip" {
  count = "${ var.create_nat_gateways ? length( var.azs ) : 0 }"
  vpc   = true

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_eip_for_nat_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags
  )}"
}

resource "aws_nat_gateway" "nat" {
  count         = "${ var.create_nat_gateways ? length( var.azs ) : 0 }"
  subnet_id     = "${ element( aws_subnet.public.*.id, count.index ) }"
  allocation_id = "${ element( aws_eip.eip.*.id, count.index) }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_nat_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags
  )}"
}
