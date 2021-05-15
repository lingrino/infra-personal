module "vpc" {
  source = "../../../../terraform-modules/vpc//"

  name_prefix    = "dev"
  vpc_cidr_block = "10.100.0.0/16"

  # I use my own VPN
  create_vpn_gateway = false

  # NAT Gateways are too expensive for my use
  create_nat_gateways = false

  # Endpoint Interfaces are too expensive for my use
  enabled_endpoint_interfaces = []

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]

  tags = {
    default = "true"
  }
}
