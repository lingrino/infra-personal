module "vpc" {
  source = "../../../../terraform-modules/vpc//"

  name_prefix    = "dev"
  vpc_cidr_block = "10.100.0.0/16"

  # NAT Gateways are too expensive for my personal use
  create_nat_gateways = false

  azs = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
  ]

  tags = var.tags
}
