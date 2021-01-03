resource "tfe_organization" "org" {
  name  = "lingrino"
  email = "sean@lingrino.com"

  collaborator_auth_policy = "two_factor_mandatory"
}

resource "tfe_organization_membership" "lingrino" {
  organization = tfe_organization.org.name
  email        = "sean@lingrino.com"
}
