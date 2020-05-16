resource "aws_route" "bastion" {
  for_each = {
    for i in range(length(setproduct(var.route_table_associations, var.bastion_cidrs))) :
    i => {
      rtid = element(var.route_table_associations, i)
      cidr = element(var.bastion_cidrs, i)
    }
  }

  route_table_id         = each.value.rtid
  instance_id            = aws_instance.bastion.id
  destination_cidr_block = each.value.cidr
}
