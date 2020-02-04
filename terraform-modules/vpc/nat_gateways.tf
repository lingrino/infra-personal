resource "aws_eip" "eip" {
  for_each = var.create_nat_gateways ? {
    for i in range(length(var.azs)) :
    i => {
      az = local.azs_list[i]
    }
  } : {}

  vpc = true

  tags = merge(
    { "Name" = "${var.name_prefix}_eip_for_nat_${replace(each.value.az, "-", "_")}" },
    var.tags
  )
}

resource "aws_nat_gateway" "nat" {
  for_each = var.create_nat_gateways ? {
    for i in range(length(var.azs)) :
    i => {
      az     = local.azs_list[i]
      subnet = aws_subnet.public[i]
      eip    = aws_eip.eip[i]
    }
  } : {}

  subnet_id     = each.value.subnet.id
  allocation_id = each.value.eip.id

  tags = merge(
    { "Name" = "${var.name_prefix}_nat_${replace(each.value.az, "-", "_")}" },
    var.tags
  )
}
