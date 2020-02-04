locals {
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
  for_each = {
    for i in range(length(var.azs)) :
    i => {
      az = local.azs_list[i]
    }
  }

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.value.az
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, each.key)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, each.key)

  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_public_${replace(each.value.az, "-", "_")}" },
    { "type" = "public" },
    var.tags
  )
}

##########################
### Private            ###
##########################
resource "aws_subnet" "private" {
  for_each = {
    for i in range(length(var.azs)) :
    i => {
      az = local.azs_list[i]
    }
  }

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.value.az
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, each.key + 8)
  ipv6_cidr_block   = cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 8, each.key + 8)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_private_${replace(each.value.az, "-", "_")}" },
    { "type" = "private" },
    var.tags
  )
}

##########################
### Intra              ###
##########################
resource "aws_subnet" "intra" {
  for_each = {
    for i in range(length(var.azs)) :
    i => {
      az = local.azs_list[i]
    }
  }

  vpc_id = aws_vpc.vpc.id

  availability_zone = each.value.az
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 6, each.key + 16)

  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = false

  tags = merge(
    { "Name" = "${var.name_prefix}_subnet_intra_${replace(each.value.az, "-", "_")}" },
    { "type" = "intra" },
    var.tags
  )
}

##########################
### Association        ###
##########################
resource "aws_route_table_association" "rta" {
  for_each = {
    for i in range(length(local.subnets)) :
    i => {
      subnet = local.subnets[i]
      rt     = local.route_tables_matching_subnets[i]
    }
  }

  subnet_id      = each.value.subnet.id
  route_table_id = each.value.rt.id
}
