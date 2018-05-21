data "aws_vpc_endpoint_service" "dynamodb" {
  service = "dynamodb"
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  auto_accept  = true
  service_name = "${ data.aws_vpc_endpoint_service.dynamodb.service_name }"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_public" {
  vpc_endpoint_id = "${ aws_vpc_endpoint.dynamodb.id }"
  route_table_id  = "${ aws_route_table.public.id }"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_general" {
  count = "${ length( var.azs ) }"

  vpc_endpoint_id = "${ aws_vpc_endpoint.dynamodb.id }"
  route_table_id  = "${ element( aws_route_table.private_general.*.id, count.index ) }"
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_data" {
  count = "${ length( var.azs ) }"

  vpc_endpoint_id = "${ aws_vpc_endpoint.dynamodb.id }"
  route_table_id  = "${ element( aws_route_table.private_data.*.id, count.index ) }"
}
