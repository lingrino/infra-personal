data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  auto_accept  = true
  service_name = "${ data.aws_vpc_endpoint_service.s3.service_name }"
}

resource "aws_vpc_endpoint_route_table_association" "s3_public" {
  vpc_endpoint_id = "${ aws_vpc_endpoint.s3.id }"
  route_table_id  = "${ aws_route_table.public.id }"
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_general" {
  count = "${ length( var.azs ) }"

  vpc_endpoint_id = "${ aws_vpc_endpoint.s3.id }"
  route_table_id  = "${ element( aws_route_table.private_general.*.id, count.index ) }"
}

resource "aws_vpc_endpoint_route_table_association" "s3_private_data" {
  count = "${ length( var.azs ) }"

  vpc_endpoint_id = "${ aws_vpc_endpoint.s3.id }"
  route_table_id  = "${ element( aws_route_table.private_data.*.id, count.index ) }"
}
