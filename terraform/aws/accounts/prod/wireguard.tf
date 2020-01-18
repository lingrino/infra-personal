module "wireguard" {
  source = "../../../../terraform-modules/wireguard//"

  name_prefix = "wireguard"

  zone_name   = "lingrino.dev"
  domain_name = "vpn.lingrino.dev"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.subnets_public_ids

  ami_owner_id  = data.terraform_remote_state.organization.outputs.account_names_to_account_ids["dev"]
  instance_type = "t3.nano"
  key_name      = var.keypair_main_name

  wg_address = "192.168.10.0/24"
  wg_port    = "51820"

  tags = var.tags
}
