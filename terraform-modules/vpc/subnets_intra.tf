resource "aws_subnet" "intra" {
  count = length(var.azs)

  vpc_id = aws_vpc.vpc.id

  availability_zone = var.azs[count.index]
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, count.index + 16)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_intra_${replace(var.azs[count.index], "-", "_")}" },
    { "type" = "intra" },
    var.tags
  )
}

resource "aws_route_table_association" "intra" {
  count = length(var.azs)

  subnet_id      = aws_subnet.intra.*.id[count.index]
  route_table_id = aws_route_table.intra.*.id[count.index]
}
