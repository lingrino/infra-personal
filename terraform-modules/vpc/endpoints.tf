##########################
### Interfaces         ###
##########################
data "aws_vpc_endpoint_service" "interfaces" {
  for_each = var.enabled_endpoint_interfaces

  service = each.value
}

resource "aws_vpc_endpoint" "interfaces" {
  for_each = {
    for i in range(length(data.aws_vpc_endpoint_service.interfaces)) :
    i => {
      interface = data.aws_vpc_endpoint_service.interfaces[i]
      subnets   = aws_subnet.private
    }
  }

  vpc_endpoint_type = "Interface"
  vpc_id            = aws_vpc.vpc.id
  service_name      = each.value.interface.service_name

  private_dns_enabled = true
  subnet_ids          = [for sn in each.value.subnets : sn.id]
  security_group_ids  = [aws_security_group.endpoints.id]
}

##########################
### Gateways           ###
##########################
data "aws_vpc_endpoint_service" "gateways" {
  for_each = var.enabled_endpoint_gateways

  service = each.value
}

resource "aws_vpc_endpoint" "gateways" {
  for_each = data.aws_vpc_endpoint_service.gateways

  vpc_id       = aws_vpc.vpc.id
  auto_accept  = true
  service_name = each.value.service_name
}

locals {
  associations = concat(
    setproduct([for gw in aws_vpc_endpoint.gateways : gw.id], [aws_route_table.public.id]),
    setproduct([for gw in aws_vpc_endpoint.gateways : gw.id], [for rt in aws_route_table.private : rt.id]),
    setproduct([for gw in aws_vpc_endpoint.gateways : gw.id], [for rt in aws_route_table.intra : rt.id]),
  )
}

resource "aws_vpc_endpoint_route_table_association" "gateways" {
  for_each = {
    for i in range(length(local.associations)) :
    i => {
      endpoint = local.associations[i][0]
      rt       = local.associations[i][1]
    }
  }

  vpc_endpoint_id = each.value.endpoint
  route_table_id  = each.value.rt
}
