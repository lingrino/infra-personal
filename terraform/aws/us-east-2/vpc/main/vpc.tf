module "vpc" {
  source = "../../../../modules/aws/vpc"

  name_prefix    = "main"
  vpc_cidr_block = "10.10.0.0/16"

  azs = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c",
  ]

  create_vpn_gateway          = false
  create_nat_gateways         = false
  enabled_endpoint_interfaces = []

  tags = {}
}
