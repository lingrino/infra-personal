resource "aws_eip" "eip" {
  for_each = var.enable_nat ? var.azs : {}

  vpc = true

  tags = merge(
    { "Name" = "${var.name_prefix}_for_nat_${replace(each.key, "-", "_")}" },
    { "az" = each.key },
    var.tags
  )
}

resource "aws_nat_gateway" "nat" {
  for_each = var.enable_nat ? var.azs : {}

  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.eip[each.key].id

  tags = merge(
    { "Name" = "${var.name_prefix}_${replace(each.key, "-", "_")}" },
    { "az" = each.key },
    var.tags
  )
}
