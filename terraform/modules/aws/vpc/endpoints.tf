##########################
### Interfaces         ###
##########################
data "aws_vpc_endpoint_service" "interfaces" {
  count = "${ length( var.enabled_endpoint_interfaces ) }"

  service = "${ var.enabled_endpoint_interfaces[count.index] }"
}

resource "aws_vpc_endpoint" "interfaces" {
  count = "${ length( var.enabled_endpoint_interfaces ) }"

  vpc_endpoint_type = "Interface"
  vpc_id            = "${ aws_vpc.vpc.id }"
  service_name      = "${ element( data.aws_vpc_endpoint_service.interfaces.*.service_name, count.index ) }"

  private_dns_enabled = true
  subnet_ids          = ["${ aws_subnet.private_general.*.id }"]
  security_group_ids  = ["${ aws_security_group.endpoints.id }"]
}

##########################
### Gateways           ###
##########################
data "aws_vpc_endpoint_service" "gateways" {
  count = "${ length( var.enabled_endpoint_gateways ) }"

  service = "${ var.enabled_endpoint_gateways[count.index] }"
}

resource "aws_vpc_endpoint" "gateways" {
  count = "${ length( data.aws_vpc_endpoint_service.gateways.*.id ) }"

  vpc_id       = "${ aws_vpc.vpc.id }"
  auto_accept  = true
  service_name = "${ element( data.aws_vpc_endpoint_service.gateways.*.service_name, count.index ) }"
}

resource "aws_vpc_endpoint_route_table_association" "gateways_public" {
  count = "${ length( data.aws_vpc_endpoint_service.gateways.*.id ) }"

  vpc_endpoint_id = "${ element( aws_vpc_endpoint.gateways.*.id , count.index ) }"
  route_table_id  = "${ aws_route_table.public.id }"
}

resource "aws_vpc_endpoint_route_table_association" "gateways_private_general" {
  count = "${ length( var.azs ) * length( data.aws_vpc_endpoint_service.gateways.*.id ) }"

  vpc_endpoint_id = "${ element( aws_vpc_endpoint.gateways.*.id , count.index ) }"
  route_table_id  = "${ element( aws_route_table.private_general.*.id, count.index ) }"
}

resource "aws_vpc_endpoint_route_table_association" "gateways_private_data" {
  count = "${ length( var.azs ) * length( data.aws_vpc_endpoint_service.gateways.*.id ) }"

  vpc_endpoint_id = "${ element( aws_vpc_endpoint.gateways.*.id , count.index ) }"
  route_table_id  = "${ element( aws_route_table.private_data.*.id, count.index ) }"
}
