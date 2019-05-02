resource "aws_internet_gateway" "igw" {
  vpc_id = "${ aws_vpc.vpc.id }"

  tags = "${ merge(
    map( "Name", "${ var.name_prefix }_internet_gateway" ),
    var.tags, module.constants.tags_default )
  }"
}

resource "aws_egress_only_internet_gateway" "igw" {
  vpc_id = "${ aws_vpc.vpc.id }"
}
