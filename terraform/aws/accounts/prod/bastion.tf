module "bastion" {
  source = "../../../../terraform-modules/bastion//"

  name_prefix = "bastion"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.subnets_public_ids

  ami_owner_id  = var.account_id_prod
  instance_type = "t3.micro"
  key_name      = var.keypair_main_name

  inbound_cidrs = ["100.64.0.0/10"]

  tags = merge(
    var.tags
  )
}
