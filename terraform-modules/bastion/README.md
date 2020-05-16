# Bastion

This module sets up a tailscale bastion instance in AWS. After the module is applied there are still manual steps that must be run to fully enable to module.

## Usage

```terraform
module "bastion" {
  source = "../../../../terraform-modules/bastion//"

  name_prefix = "bastion"

  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.subnets_public_ids

  ami_owner_id  = var.account_id_prod
  instance_type = "t3.micro"
  key_name      = var.keypair_main_name

  inbound_cidrs = ["100.64.0.0/10"]

  tags = var.tags
}
```

## Post Apply

Even though the bastion is created in an ASG there is currently no way to connect to tailscale in an automated way and so you must manally ssh into the instance and run some commands every time the instance is cycled. Check out the [tailscale article](https://tailscale.com/kb/1021/install-aws) forr the most up to date instructions.
