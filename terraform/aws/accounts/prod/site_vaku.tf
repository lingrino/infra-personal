module "vaku" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "vaku"

  dns_names_to_zone_names = {
    "vaku.io"    = "vaku.io"
    "*.vaku.io"  = "vaku.io"
    "vaku.dev"   = "vaku.dev"
    "*.vaku.dev" = "vaku.dev"
  }

  tags = "${ var.tags }"
}

output "vaku_bucket_name" {
  value = "${ module.vaku.bucket_name }"
}

output "vaku_distribution_id" {
  value = "${ module.vaku.distribution_id }"
}

output "vaku_deployer_access_key_id" {
  value = "${ module.vaku.deployer_access_key_id }"
}

output "vaku_deployer_secret_access_key" {
  value = "${ module.vaku.deployer_secret_access_key }"
}
