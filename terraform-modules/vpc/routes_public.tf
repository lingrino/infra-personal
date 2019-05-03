resource "aws_route_table" "public" {
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_route_table_public" ),
    var.tags
  )}"
}

resource "aws_route" "public_igw" {
  route_table_id         = "${ aws_route_table.public.id }"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${ aws_internet_gateway.igw.id }"
}

resource "aws_route" "ipv6_public_igw" {
  route_table_id              = "${ aws_route_table.public.id }"
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = "${ aws_internet_gateway.igw.id }"
}
