resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    {"Name" = "${var.name_prefix}_internet_gateway"},
    var.tags
  )
}

resource "aws_egress_only_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}
