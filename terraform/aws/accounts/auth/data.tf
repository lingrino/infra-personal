data "tfe_organization" "lingrino" {
  name = "lingrino"
}

data "tfe_variable_set" "all" {
  organization = data.tfe_organization.lingrino.name
  name         = "all"
}
