resource "aws_route_table" "intra" {
  count  = "${ length( var.azs ) }"
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_route_table_intra_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags
  )}"
}
