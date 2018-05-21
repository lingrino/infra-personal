resource "aws_route_table" "private_data" {
  count  = "${ length( var.subnets_private_data_azs_to_cidrs ) }"
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map(
      "Name",
      "${ var.name_prefix }_route_table_private_data_${ replace( element( keys( var.subnets_private_data_azs_to_cidrs ), count.index ), "-", "_" ) }"
    ),
    var.tags,
    module.constants.tags_default )
  }"
}
