module "vault" {
  source = "../../../../terraform-modules/vault//"

  name_prefix = "vault"
  dr_region   = "us-west-2"

  vpc_id        = module.vpc.vpc_id
  alb_subnets   = module.vpc.subnets_public_ids
  ec2_subnets   = module.vpc.subnets_public_ids
  ingress_cidrs = ["100.64.0.0/10"] # Tailscale cidr

  domain_name     = "vault.lingrino.dev"
  certificate_arn = module.cert_vault.certificate_arn

  ami_owner_id  = var.account_id_prod
  instance_type = "t3.small"
  key_name      = var.keypair_main_name

  min_size         = 1
  max_size         = 2
  desired_capacity = 1

  tags = var.tags
}

module "cert_vault" {
  source = "../../../../terraform-modules/acm-certificate//"

  zone_name   = "lingrino.dev."
  domain_name = "vault.lingrino.dev"

  tags = var.tags

  providers = {
    aws.cert = aws.cert
    aws.dns  = aws.dns
  }
}

resource "aws_route53_record" "vault" {
  zone_id = data.aws_route53_zone.lingrino_dev.zone_id
  name    = "vault.lingrino.dev"
  type    = "A"

  alias {
    name                   = module.vault.alb_dns_name
    zone_id                = module.vault.alb_zone_id
    evaluate_target_health = false
  }
}
