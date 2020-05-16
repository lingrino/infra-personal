module "bastion" {
  source = "../../../../terraform-modules/bastion//"

  name_prefix = "bastion"

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.subnets_public_ids[0]

  ami_owner_id  = var.account_id_prod
  instance_type = "t3.micro"
  key_name      = var.keypair_main_name

  bastion_cidrs            = ["100.64.0.0/10"] # Tailscale cidr
  route_table_associations = module.vpc.route_table_ids

  tags = merge(
    var.tags
  )
}
