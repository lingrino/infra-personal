resource "aws_subnet" "public" {
  for_each = toset(var.azs)

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, each.key)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, each.key)

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_public_${replace(each.key, "-", "_")}" },
    { "type" = "public" },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
