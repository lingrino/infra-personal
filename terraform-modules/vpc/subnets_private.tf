resource "aws_subnet" "private" {
  count = length(var.azs)

  vpc_id = aws_vpc.vpc.id

  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, count.index + 8)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, count.index + 8)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_private_${replace(var.azs[count.index], "-", "_")}" },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.azs)

  subnet_id      = aws_subnet.private.*.id[count.index]
  route_table_id = aws_route_table.private.*.id[count.index]
}
