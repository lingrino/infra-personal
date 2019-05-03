# This static site is just meant to hold all of the sites that I am currently not using and
# display a basic landing page that is defined in the module.
module "site_landing" {
  source = "../../../../terraform-modules/static-site//"

  name_prefix = "site-landing"

  dns_names_to_zone_names = {
    "hoo.dev"        = "hoo.dev"
    "*.hoo.dev"      = "hoo.dev"
    "policies.dev"   = "policies.dev"
    "*.policies.dev" = "policies.dev"
    "releases.dev"   = "releases.dev"
    "*.releases.dev" = "releases.dev"
  }

  tags = "${ var.tags }"
}
