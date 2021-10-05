locals {
  # letters is used to map availability zone letters (a, b, c, etc...) to
  # a consistent index so that each az letter has the same set of cidrs
  letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]

  subnets = concat(
    [for _, sn in aws_subnet.public : sn],
    [for _, sn in aws_subnet.private : sn],
    [for _, sn in aws_subnet.intra : sn],
  )
}

##########################
### Public             ###
##########################
resource "aws_subnet" "public" {
  for_each = var.azs

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value["public"]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, index(local.letters, replace(each.key, data.aws_region.current.name, "")))

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    { "Name" = "${var.name_prefix}_public_${replace(each.key, "-", "_")}" },
    { "type" = "public" },
    { "az" = each.key },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = var.azs

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

##########################
### Private            ###
##########################
resource "aws_subnet" "private" {
  for_each = var.azs

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value["private"]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, index(local.letters, replace(each.key, data.aws_region.current.name, "")) + 32)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_private_${replace(each.key, "-", "_")}" },
    { "type" = "private" },
    { "az" = each.key },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  for_each = var.azs

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

##########################
### Intra              ###
##########################
resource "aws_subnet" "intra" {
  for_each = var.azs

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.key
  cidr_block        = each.value["intra"]
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, index(local.letters, replace(each.key, data.aws_region.current.name, "")) + 64)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_intra_${replace(each.key, "-", "_")}" },
    { "type" = "intra" },
    { "az" = each.key },
    var.tags
  )
}

resource "aws_route_table_association" "intra" {
  for_each = var.azs

  subnet_id      = aws_subnet.intra[each.key].id
  route_table_id = aws_route_table.intra[each.key].id
}
