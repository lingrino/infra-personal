data "cloudflare_api_token_permission_groups" "all" {}

data "tfe_organization" "lingrino" {
  name = "lingrino"
}

data "tfe_workspace" "prod" {
  organization = data.tfe_organization.lingrino.name
  name         = "aws-accounts-prod"
}

data "tfe_variable_set" "all" {
  organization = data.tfe_organization.lingrino.name
  name         = "all"
}
