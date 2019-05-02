resource "aws_route_table" "private_data" {
  count  = "${ length( var.azs ) }"
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_route_table_private_data_${ replace( var.azs[count.index], "-", "_" ) }" ),
    var.tags, module.constants.tags_default )
  }"
}
