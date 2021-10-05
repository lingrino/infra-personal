##########################
### Public             ###
##########################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_public" },
    { "type" = "public" },
    var.tags
  )
}

resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "ipv6_public_igw" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

##########################
### Private            ###
##########################
resource "aws_route_table" "private" {
  for_each = var.azs

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_private_${replace(each.key, "-", "_")}" },
    { "type" = "private" },
    { "az" = each.key },
    var.tags
  )
}

resource "aws_route" "nat" {
  for_each = var.enable_nat ? var.azs : {}

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[each.key].id
}

resource "aws_route" "private_eoigw" {
  for_each = var.azs

  route_table_id              = aws_route_table.private[each.key].id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.igw.id
}

##########################
### Intra              ###
##########################
resource "aws_route_table" "intra" {
  for_each = var.azs

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_intra_${replace(each.key, "-", "_")}" },
    { "type" = "intra" },
    { "az" = each.key },
    var.tags
  )
}

##########################
### Default            ###
##########################
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = merge(
    { "Name" = "DO_NOT_USE" },
    { "description" = "do not use. default route table options created by AWS in this VPC" },
    var.tags
  )
}
