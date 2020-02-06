locals {
  route_tables = concat(
    [aws_route_table.public],
    [for _, rt in aws_route_table.private : rt],
    [for _, rt in aws_route_table.intra : rt],
  )

  # repeats the public route table equal to the number of subnets
  # so that the length matches local.subnets
  route_tables_matching_subnets = concat(
    [for _ in range(length(aws_subnet.public)) : aws_route_table.public],
    [for _, rt in aws_route_table.private : rt],
    [for _, rt in aws_route_table.intra : rt],
  )
}

##########################
### Public             ###
##########################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_route_table_public" },
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
  for_each = {
    for i in range(length(aws_subnet.private)) :
    i => {
      az = local.azs_list[i]
    }
  }

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_route_table_private_${replace(each.value.az, "-", "_")}" },
    { "type" = "private" },
    var.tags
  )
}

resource "aws_route" "nat" {
  for_each = var.create_nat_gateways ? {
    for i in range(length(aws_route_table.private)) :
    i => {
      nat = aws_nat_gateway.nat[i]
      rt  = aws_route_table.private[i]
    }
  } : {}

  route_table_id         = each.value.rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = each.value.nat.id
}

resource "aws_route" "private_eoigw" {
  for_each = {
    for i in range(length(aws_route_table.private)) :
    i => {
      rt = aws_route_table.private[i]
    }
  }

  route_table_id              = each.value.rt.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.igw.id
}

##########################
### Intra              ###
##########################
resource "aws_route_table" "intra" {
  for_each = {
    for i in range(length(aws_subnet.intra)) :
    i => {
      az = local.azs_list[i]
    }
  }

  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { "Name" = "${var.name_prefix}_route_table_intra_${replace(each.value.az, "-", "_")}" },
    { "type" = "intra" },
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
