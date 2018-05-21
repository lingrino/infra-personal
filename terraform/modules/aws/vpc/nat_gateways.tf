# Note: Nat gateways are expensive for a simple personal AWS account
# This is the setup that *should* exist.
# resource "aws_eip" "eip" {
#   count = "${ length( var.azs ) }"
#   vpc = true
#   tags = "${ merge(
#     map(
#       "Name",
#       "${ var.name_prefix }_eip_for_nat_${ replace( element( keys( var.azs ), count.index ), "-", "_" ) }"
#     ),
#     var.tags,
#     module.constants.tags_default )
#   }"
# }
# resource "aws_nat_gateway" "nat" {
#   count = "${ length( var.azs ) }"
#   subnet_id     = "${ element( aws_subnet.public.*.id, count.index ) ) }"
#   allocation_id = "${ element( aws_eip.eip.*.id, count.index))}"
#   tags = "${ merge(
#     map(
#       "Name",
#       "${ var.name_prefix }_eip_for_nat_${ replace( element( keys( var.azs ), count.index ), "-", "_" ) }"
#     ),
#     var.tags,
#     module.constants.tags_default )
#   }"
# }
